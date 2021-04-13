# docker-postfix

## DKIMのセットアップ

DKIM鍵を生成するためにホストにOpenDKIMと依存パッケージをインストールする。（OpenDKIMはEPELに収録されている）

```bash:shell
dnf install -y opendkim perl-Getopt-Long
```

`smtp/create_dkim_key.sh` を実行する

```bash:shell
./smtp/create_dkim_key.sh
```

以下のファイルが生成される

- `smtp/mount/mail.private`
    - DKIM鍵
    - マウントして使用する
- `smtp/mount/mail.txt`
    - DKIMレコードの内容（bind用zoneファイルフォーマット）
    - DNSに適切に追加する

## 各コンテナ・アプリケーションの設定

手動でComposeファイルを書き換えたりアプリケーション上で設定する場合は `smtp-server:587` に設定する。

- TLSやSSLはオフとし、認証は使用しない
- 初期設定では587ポートをコンテナ間リンクにのみ開いているため、外部からは接続できない
    - docker-postfix自体も初期設定ではアクセス元を `127.0.0.0/8, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16` に制限している

SHWの初期化時に注入する場合は `setup/.env` のSMTPサーバの設定を以下のように書き換えてから初期化スクリプトを実行する。

```plaintext
SMTP_SERVER=smtp-server
SMTP_PORT=587
```
