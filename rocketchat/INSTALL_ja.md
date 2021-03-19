# rocket.chat

## 管理者アカウントの作成方法

インストール時に作成する。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-rocketchat-saml.json` をインポートし「保存」
2. 「SAML鍵」タブを開き「新しい鍵を生成」

### rocket.chat管理画面

1. 管理者アカウントでログインし、左上メニューから「管理」→「SAML」
2. 各項目を以下のように設定して右上の「変更を保存」

- 有効にする
    - ON
- カスタムプロバイダー
    - `keycloak`（任意）
- カスタムエントリーポイント
    - `<PROTOCOL>://auth.<DOMAIN>/auth/realms/<REALM>/protocol/saml`
- IDP SLOリダイレクトURL
    - `<PROTOCOL>://auth.<DOMAIN>/auth/realms/<REALM>/protocol/saml/clients/rc.<DOMAIN>`
- カスタム照合者 (Issuer)
    - `app-rocketchat`
- 証明書
    - 後述
- マッピング
    - 後述

置換用文字列は以下に置き換える。

- `<PROTOCOL>`
    - `http` または `https`
- `<DOMAIN>`
    - サーバのドメイン（e.g. `example.com`）
- `<REALM>`
    - Keycloakのレルム名

#### 証明書

##### カスタム証明書

Keycloak管理画面の左メニューから「レルムの設定」→「鍵」→RSA256の「証明書」ボタンを押して出てくる文字列を以下の `<KEYCLOAK_REALM_RS256_CERTIFICATE>` と置き換える。

```PEM
-----BEGIN CERTIFICATE-----
<KEYCLOAK_REALM_RS256_CERTIFICATE>
-----END CERTIFICATE-----
```

##### 公開証明書の内容

Keycloak管理画面のrocket.chat用クライアント設定→「SAML鍵」の「証明書」の内容を以下の `<KEYCLOAK_CLIENT_SAML_CERTIFICATE>` と置き換える。

```PEM
-----BEGIN CERTIFICATE-----
<KEYCLOAK_CLIENT_SAML_CERTIFICATE>
-----END CERTIFICATE-----
```

##### 秘密鍵の内容

Keycloak管理画面のrocket.chat用クライアント設定→「SAML鍵」の「秘密鍵」の内容を以下の `<KEYCLOAK_CLIENT_SAML_CERTIFICATE>` と置き換える。

```PEM
-----BEGIN RSA PRIVATE KEY-----
<KEYCLOAK_CLIENT_SAML_PRIVATE>
-----END RSA PRIVATE KEY-----
```

#### マッピング

```JSON
{
  "email": "email",
  "username": "username",
  "name": "name",
  "__identifier__": "id"
}
```

表示名を変更したい場合は `name` の値を割り当てたいKeycloakのマッパー設定の `SAML Attribute Name` の値に変更する。
