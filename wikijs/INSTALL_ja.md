# CodiMD

## 管理者アカウントの作成方法

インストール時に作成する。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-wikijs-saml.json` をインポートし「保存」
2. 「SAML鍵」タブを開き「新しい鍵を生成」
3. 「設定」タブを開く
4. 「有効なリダイレクトURI」と「SAMLを処理するマスターURL」の内容に含まれる `WIKIJS_REDIRECT_URL_HASH` を、Wiki.jsの設定画面の一番下に表示されている「JSCallback URL / Redirect URL」の対応部分の文字列で置き換える

### Wiki.js管理画面

1. 管理者アカウントでログインし、右上の歯車アイコンから管理画面→「認証」
2. 「認証方式を追加」→「SAML 2.0」
3. 各項目を以下のように設定して右上の「適用」（記述のないものは変更不要）

- 表示名
    - `SAML 2.0`（任意）
- 有効
    - ON
- Entry Point
    - `<PROTOCOL>://auth.<DOMAIN>/auth/realms/<REALM>/protocol/saml/clients/wikijs.<DOMAIN>`
- Issuer
    - `app-wikijs`
- Certificate
    - 後述
- ​Private Certificate
    - 後述
- ​Signature Algorithm
    - `sha256`
- ​Request Binding
    - `HTTP-Redirect`
​- Unique ID Field Mapping
    - `id`
​- Email Field Mapping
    - `email`
​- Display Name Field Mapping
    - `displayName`
    - 表示名を変えたい場合は、割り当てたいKeycloakのマッパー設定の `SAML Attribute Name` の値に変更する
- ​Avatar Picture Field Mapping
    - 空欄
- 自己登録を許可する
    - ON
- 割り当てるグループ
    - 任意（標準ではAdminとGuestしかないため、適当にUsers等を作成しておくとよい）

#### Certificate

Keycloak管理画面の左メニューから「レルムの設定」→「鍵」→RSA256の「証明書」ボタンを押して出てくる文字列を以下の `<KEYCLOAK_REALM_RS256_CERTIFICATE>` と置き換える。

```PEM
-----BEGIN CERTIFICATE-----
<KEYCLOAK_REALM_RS256_CERTIFICATE>
-----END CERTIFICATE-----
```

#### ​Private Certificate

Keycloak管理画面のWiki.js用クライアント設定→「SAML鍵」→「秘密鍵」の内容を以下の `<KEYCLOAK_CLIENT_SAML_CERTIFICATE>` と置き換える。

```PEM
-----BEGIN RSA PRIVATE KEY-----
<KEYCLOAK_CLIENT_SAML_PRIVATE>
-----END RSA PRIVATE KEY-----
```
