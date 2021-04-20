# ステップバイステップガイド

- RHEL8互換環境を前提とする
    - 非互換のディストロではコマンドやシェルスクリプトの読み替え・修正が必要
- 作業はroot権限で行う
- 必要なスペックは使用するアプリケーションによって前後する
    - CPUはシングルスレッド性能にもよるが少なくとも2コア以上を推奨
    - 全て同時起動する場合はメモリ8GB以上を推奨
- 全てのイメージをインストールする場合、イメージだけで16GB強の空き容量が必要
    - これ以外に各コンテナが保存するデータのための領域が必要
- 動作確認は4コア/メモリ16GB/SSD500GBで実施している

## Docker Composeのセットアップ

### Dockerのインストール

```bash
# リポジトリ追加
$ dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# インストール
$ dnf install -y docker-ce

# 起動
$ systemctl start docker

# OS起動時に開始するよう設定変更
$ systemctl enable docker

# 設定と状態の確認
$ systemctl status docker
```

- アップデートの確認は `$ dnf info docker-ce`
- アップデートは `$ dnf upgrade docker-ce`

### Docker Composeのインストール

[公式の手順](https://docs.docker.jp/compose/install.html#linux-compose)通り。

```bash
# コンパイル済バイナリをダウンロード
$ curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 実行権限を付与
$ chmod +x /usr/local/bin/docker-compose
```

- [githubのreleases](https://github.com/docker/compose/releases)を確認して最新版を使用する
- アップデートはバージョンの数字を変えてcurlを再実行

## SHWのセットアップ

### 1. ファイルの配置

- [githubからソース一式を取得](https://github.com/macropygia/dc-sso-self-hosted-workspace)し任意のディレクトリに配置（`git clone` または書庫をDLして展開）
- 特記なき場合SHWのルートで作業する
    - makeコマンドはSHWのルートで実行する
    - dockerコマンドはどこで実行してもよい

### 2. 変数の設定と適用

`setup/.env.sample` を `setup/.env` にリネーム（ないしコピー）して変数を設定する。

- LANG
    - 言語（例: `ja`）
- LOCALE
    - ロケール（例: `ja_JP`）
    - データベースの初期化にも使われる
- TZ
    - タイムゾーン（例: `Asia/Tokyo`）
    - 使用するtzdataのバイナリの絶対パスの `/usr/share/zoneinfo/` より後の部分
- LOCAL_IP
    - サーバのローカルIP（例: `192.168.1.234`）
- DOMAIN
    - サーバへのアクセス時に使用するドメイン（例: `shw.test`）
- REALM
    - 使用するKeycloakのレルム名（例: `shw`）
- SSL
    - SSLを使用するかどうか（ `true` or `false` ）
- HSTS
    - HSTSを使用するかどうか（ `true` or `false` ）
    - `SSL=true` の場合のみ有効
    - 一度HSTS有効でHTTPSアクセスしてからHTTPに変更する場合はHSTSキャッシュの削除が必要
- SELF
    - 自己署名認証局を使用するかどうか（ `true` or `false` ）
    - `SSL=true` の場合のみ有効
- SMTP_SERVER
    - SMTPサーバのホスト名（同梱のMailCatcherの場合: `smtp-dummy`）
- SMTP_PORT
    - SMTPサーバのポート（同梱のMailCatcherの場合: `1025`）

設定後 `setup/init.sh` を実行する。

```bash
$ ./setup/init.sh
```

下記の処理が行われる。

- 置換用文字列を設定した値に置換
    - nginx-proxyの設定ファイル名も含む
- 乱数挿入用文字列を生成した乱数に置換（ `<BASE64_48>` と `<ALNUM_48>` ）
- 置換用コメント記号を削除し設定項目を有効化

### 3. Docker Volumeの作成

`setup/create_volumes.sh` を実行する。

```bash
$ ./setup/create_volumes.sh
```

### 4. 自己署名認証局・サーバ証明書関連作業（使用する場合のみ）

#### 証明書の作成

ローカルネットワークでテストする場合は `setup/create_self-sign_cert.sh` をそのまま実行する。
外向きに公開する場合は `setup/create_self-sign_cert.sh` の `IP=0.0.0.0` の部分をサーバのグローバルIPに書き換えてから実行する。

- Dockerイメージ [self-sign-cert](https://github.com/t-kuni/self-sign-cert) を使用する（[dockerhub](https://hub.docker.com/r/tkuni83/self-sign-cert), [作者によるQiita記事](https://qiita.com/t-kuni/items/d3d72f429273cf0ee31e)）

```bash
$ cd /root/docker/shw/setup
$ ./create_self-sign_cert.sh
```

`self-sign-cert` ディレクトリの中に鍵と証明書が生成され、 `server.key` と `server.crt` が `proxy/mount/certs` にコピーされる。（既存のファイルは上書きされる）

#### ホストへの自己署名認証局の登録とCAバンドルのコピー

`setup/register_self-sign_cert.sh` を実行する。このスクリプトの実行内容は以下の通り。

- 前項で作成した自己署名認証局の証明書をホストマシンの登録用ディレクトリにコピー
- ホストマシンに登録
- 自己署名の認証局が追加されたホストマシンのCAバンドル（PEMとJava用キーストア）をSHWのディレクトリにコピー
    - これらのファイルは各コンテナにマウントして使用される

ホストマシンから登録を解除したい場合は `setup/unregister_self-sign_cert.sh` を実行する

### 5. ファイアーウォールの設定

以下のポートを適切に設定する。

- 80 : http
- 443 : https
- 4040 : Scope用（絶対に外向きに開けないこと）
- 9000 : Portainer用（絶対に外向きに開けないこと）

一時的にローカルネットワーク内の単一のIPに全てのポートを開放する場合は以下のように設定する。（永続化する場合は最初のコマンドに `--permanent` をつける）

```bash
$ firewall-cmd --add-source=192.168.1.2/32 --zone=trusted
$ firewall-cmd --reload
```

### 6. hostsの編集（必要な場合のみ）

テスト用のドメインでサーバにアクセスできるようにクライアントのhostsを編集する。
Linuxでは `/etc/hosts` 、Windowsでは `C:\Windows\System32\drivers\etc\hosts` 。
以下はサーバのローカルIPが `192.168.1.234` 、ドメインが `shw.test` の場合。

```text
192.168.1.234    auth.shw.test
192.168.1.234    gitlab.shw.test
192.168.1.234    gitea.shw.test
192.168.1.234    codimd.shw.test
192.168.1.234    wikijs.shw.test
192.168.1.234    growi.shw.test
192.168.1.234    mm.shw.test
192.168.1.234    rc.shw.test
192.168.1.234    op.shw.test
192.168.1.234    taiga.shw.test
192.168.1.234    penpot.shw.test
192.168.1.234    nc.shw.test

192.168.1.234    pga.shw.test
192.168.1.234    pma.shw.test
192.168.1.234    mongo.shw.test
192.168.1.234    redis.shw.test
192.168.1.234    eshq.shw.test
192.168.1.234    rmq.shw.test
192.168.1.234    mc.shw.test
```

- Linuxなら `dnsmasq` などを使ってもよい
    - dnsmasqは2021年1月に脆弱性が発見されたため2.83以降を使用のこと

## Composeプロジェクトのセットアップと実行

Composeファイル内の設定項目を適宜編集する。
基本的にアプリケーション毎に固有の内容のため、それぞれのアプリケーションのドキュメントや各ディレクトリの `INSTALL_ja.md` を参照のこと。

### Composeプロジェクトの実行方法

- コンテナの作成・削除には同梱の `Makefile` を使用する
- 詳しい使い方は[MakefileのREADME](https://github.com/macropygia/dc-multiple-project-makefile/blob/main/README_ja.md)を参照
- 利用可能なComposeプロジェクト（≒コンテナ）は `$ make ls` で一覧できる
- コンテナ作成後の起動や停止はモニタリングツール（Scope, Portainer）を使った方が楽
- もちろん個々のディレクトリで手動でComposeコマンドを実行しても構わない

### MongoDBの初期化

データベース系のコンテナは原則として初回起動時に `initdb.d` にマウントされた内容で初期化されるが、MongoDBはレプリケーションを使用する（rocket.chatに必要）都合で個別に初期化する必要がある。

初期化用シェルスクリプトを実行する。

```bash
$ ./mongo/initdb.sh
```

- MongoDBのイメージのDLから始まるため時間がかかる
- DLが終わってコンテナが起動するとログが高速で流れる
- ログが停止し以下のようなメッセージで止まったら `Ctrl+C` を押す

```json
{"t":{"$date":"2021-00-00T00:00:00.000+09:00"},"s":"I",  "c":"NETWORK",  "id":12345,   "ctx":"listener","msg":"Waiting for connections","attr":{"port":27017,"ssl":"off"}}
```

初期化用プロセスが停止しているか確認する。

```bash
$ docker ps
```

もし以下のように起動中のコンテナ情報が表示されたら、CONTAINER ID（12桁のハッシュ）を指定して停止・削除する。

```text
CONTAINER ID   IMAGE            ...
1234567890ab   mongo:4-bionic   ...

$ docker stop 1234567890ab
$ docker rm 1234567890ab
```

### コンテナモニタリングツールの起動

Scopeを起動する。

```bash
$ make scope up
```

ローカルネットワーク内から `http://<LOCAL_IP>:4040` にアクセスするとScopeが表示される。

- Scopeはセットアップ不要で見た目も楽しくモチベ的におすすめ
    - ただし稼働するコンテナが増えてくると相関図はカオスになる
- Portainerはオーソドックスなリスト形式で表示される
    - 初回アクセス時に初期アカウントの作成と接続先の選択が必要
        - 初期アカウント作成画面の一番下のチェックボックスはテレメトリデータ送信の承認なので注意
    - 接続先は `http://<LOCAL_IP>:9000`
    - Scopeより機能は多い

### リバースプロキシ・ダミーSMTPサーバの起動

リバースプロキシ `nginx-proxy` とダミーSMTPサーバ `MailCatcher` を起動する。

```bash
$ make proxy mc up
```

- 先の手順で開始したScopeを表示している場合、DLが終わってコンテナが起動すると画面内に出現する
- nginx-proxyはDockerと連携してリバースプロキシの設定を自動で行う
    - nginx-proxy起動中はコンテナを起動するとなにもしなくても各アプリケーションのdocker-compose.ymlで設定したドメインでアクセスできる
- MailCatcherは `http://mc.<DOMAIN>` からアクセスできる（標準では http://mc.shw.test ）
    - MailCatcherのデータは揮発性なので注意

### Keycloakの起動

```bash
$ make _kc up
```

- 他のアプリケーションのインストールにKeycloakが必要になるため、最初にKeycloakを起動してレルム作成やクライアント設定のインポート等を行っておく
    - 詳しくは `keycloak/INSTALL_ja.md` を参照
- `_kc` はKeycloakと依存関係のコンテナをまとめて操作対象にするビルトインプリセット
    - 全てのアプリケーションに用意してある
    - ビルトインプリセットは `shw.mk` に記述してある
- `<PROTOCOL>://auth.<DOMAIN>` からアクセスできる（標準では http://auth.shw.test ）
- 先の手順で開始したScopeを表示している場合、プロキシやDBと接続する様子が見られる

### pgAdminの起動

pgAdminをはじめ、データベース類にはWebUIを用意してある。（RabbitMQはビルトイン）

```bash
$ make pga up
```

- pgAdminにはComposeファイルで設定したメールアドレスとパスワードでログインできる
    - pgAdminからPostgreSQLへの接続はpgAdmin内で設定する
- データベース等のWebUIは `127.0.0.0/8, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16` からのアクセスのみ許可されている（nginx-proxyの `NETWORK_ACCESS=internal` による）
    - 標準ではWebUIにはSSLは使用しない

## 各アプリケーションとKeycloakの連携

各アプリケーションのディレクトリにある `INSTALL_ja.md` を参照のこと。
