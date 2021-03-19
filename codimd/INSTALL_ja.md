# CodiMD

## 管理者アカウントの作成方法

管理者アカウントは存在しない。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-codimd-saml.json` をインポートし「保存」
2. 「SAML鍵」タブを開き「新しい鍵を生成」
3. 左メニューから「レルムの設定」→「鍵」を開く
4. RSA256の「証明書」ボタンを押して出てくる文字列を `gitlab/keycloak_relm.crt` の2行目の `<KEYCLOAK_REALM_RSA256_CERTIFICATE>` と置き換えて保存する

### docker-compose.yml

表示名を変更したい場合は `CMD_SAML_ATTRIBUTE_USERNAME` の値を割り当てたいKeycloakのマッパー設定の `SAML Attribute Name` の値に変更する。

```yaml
- CMD_SAML_ATTRIBUTE_USERNAME=username
```
