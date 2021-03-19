# Growi

## 管理者アカウントの作成方法

インストール時に作成する。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-growi-saml.json` をインポートし「保存」
2. 「SAML鍵」タブを開き「新しい鍵を生成」
3. 左メニューから「レルムの設定」→「鍵」を開く
4. RSA256の「証明書」ボタンを押して出てくる文字列をメモしておく (※1)

### docker-compose.yml

証明書の文字列(※1)を `SAML_CERT` の `<KEYCLOAK_REALM_RSA256_CERTIFICATE>` と置き換えて保存する。

```yaml
- |-
  SAML_CERT=-----BEGIN CERTIFICATE-----
  MIIHOGEHOGEHOGEHOGEHOGEHOGEHOGEHOGEHOGEHOGEHOGEHOGEHOGEHOGE...
  -----END CERTIFICATE-----
```

表示名を変更したい場合は `SAML_ATTR_MAPPING_FIRST_NAME` と `SAML_ATTR_MAPPING_LAST_NAME` の値を割り当てたいKeycloakのマッパー設定の `SAML Attribute Name` の値に変更する。
ただし必ず `<FIRST_NAMEで指定した内容><半角スペース><LAST_NAMEで指定した内容>` のフォーマットになる。（空文字列は `undefined` に変換される）

```yaml
- SAML_ATTR_MAPPING_FIRST_NAME=firstName
- SAML_ATTR_MAPPING_LAST_NAME=lastName
```

### GROWI管理画面

1. 管理者アカウントでログインし、左メニューの下の歯車アイコン→「セキュリティ設定」→「認証機構設定」→「SAML」
2. 「SAML を有効にする」チェックボックスをONにする
3. 「Basic Settings」と「Attribute Mapping」の内容がdocker-compose.ymlから読み込まれていることを確認する
4. 最下部の「更新」ボタンを押す
