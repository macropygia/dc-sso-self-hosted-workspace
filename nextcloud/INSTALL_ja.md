# NextCloud

## 管理者アカウントの作成方法

`docker-compose.yml` の `environment` で作成する。

```yaml
- NEXTCLOUD_ADMIN_USER=webmaster
- NEXTCLOUD_ADMIN_PASSWORD=Pa55w@rd
```

### SAML有効化後のID/Passログイン

SAMLログイン有効化後にID/Passでログインしたい場合は `/login?direct=1` から行う。

## 初回起動後のconfig.php設定

初回起動時にブラウザで表示すると「信頼できないドメインを介したアクセス」と表示され、 `config.php` を編集するよう促される。
一旦コンテナを終了・削除（ `down` ）し、自動生成されている `nextcloud/volumes/config/config.php` を以下のように編集してから起動（ 'up' ）する。

```php:config.php
  ...
  'trusted_domains' =>
  array (
    0 => 'localhost',
    1 => 'nc.<DOMAIN>',
  ),
  'datadirectory' => '/var/www/html/data',
  'dbtype' => 'pgsql',
  'version' => '21.0.0.18',
  'overwritehost' => 'nc.<DOMAIN>',
  'overwriteprotocol' => '<PROTOCOL>',
  'overwrite.cli.url' => '<PROTOCOL>://nc.<DOMAIN>',
  ...
```

- `<DOMAIN>`: サーバのドメイン（e.g. `example.com`）
- `<PROTOCOL>`: `http` または `https`

## SSO設定

参照元: https://qiita.com/ogawa_pro/items/ec25ecf90f2b0fdeff37

### Keycloak管理画面(1)

1. 左メニューから「レルムの設定」→「鍵」を開く
2. RSA256の「証明書」ボタンを押して出てくる文字列をメモしておく(※1)

### NextCloud管理画面

(TBA)

### Keycloak管理画面(2)

(TBA)
