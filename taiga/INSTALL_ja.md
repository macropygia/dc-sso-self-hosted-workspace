# TAIGA

## docker-compose.ymlの編集

- `<TAIGA_SECRET_KEY>` をランダムな文字列に置き換える
    - 全て同一の内容とすること（コンテナ間の認証に使用？）

## RabbitMQのVirtual Host作成

docker-composeで動作するRabbitMQには初回起動時に自動で初期化する方法がない（または作者が辿り着けていない）ため、予めTAIGA用のVirtual Host（RDBMSにおけるdatabaseに相当する概念）をWebUIから作成しておく必要がある。

1. `make rmq proxy up` でRabbitMQとnginx-proxyを起動
2. `<PROTOCOL>//rmq.<DOMAIN>` にアクセス（標準では http://rmq.shw.test ）
3. ID `root` , Pass `root` でログイン（設定を変更していない場合）
4. 上部「Admin」タブ → サイドメニュー「Virtual Hosts」→「Add a new virtual host」アコーディオンを開く
5. 「Name」に `taiga` と入力して「Add virtual host」ボタンを押す

## 管理者アカウントの作成

1. 一度TAIGAを通常起動（`up`）してアクセスできることを確認してから終了（`down`）する
2. `taiga/createsuperuser.sh` を実行して指示に従う

### 管理画面

`<PROTOCOL>://taiga.<DOMAIN>/admin/` からアクセスできる。
専用の管理画面ではなくDjangoの管理画面を使用する。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-taiga-oidc.json` をインポートし「保存」
2. 「クレデンシャル」タブを開き「シークレット」の内容をメモする (※1)
3. 表示名を変更したい場合は `トークンクレーム名` が `name` のマッパー設定を変更する

### docker-compose.yml

シークレットの文字列(※1)を `GITLAB_API_CLIENT_SECRET` の `<KEYCLOAK_CLIENT_SECRET>` と置き換えて保存する。

```yaml
- GITLAB_API_CLIENT_SECRET=abc12345-defg-6789-hijk-lmn0pqrstuvw
```
