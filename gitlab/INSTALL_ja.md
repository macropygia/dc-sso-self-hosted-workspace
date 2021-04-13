# GitLab

## 管理者アカウントの作成方法

`docker-compose.yml` の `environment` で作成する。

```yaml
- GITLAB_ROOT_PASSWORD=Pa55w@rd
- GITLAB_ROOT_EMAIL=webmaster@<DOMAIN>
```

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-gitlab.json` をインポートし「保存」
2. 「SAML鍵」タブを開き「新しい鍵を生成」
3. 左メニューから「レルムの設定」→「鍵」を開く
4. RSA256の「証明書」ボタンを押して出てくる文字列を `codimd/mount/keycloak_relm.crt` の2行目の `<KEYCLOAK_REALM_RSA256_CERTIFICATE>` と置き換えて保存する
5. `gitlab/getfingerprint.sh` を実行する
6. 出力された `SHA1 Fingerprint=` より後の部分をメモする (※1)

### docker-compose.yml

フィンガープリント(※1)を `OAUTH_SAML_IDP_CERT_FINGERPRINT` の `<KEYCLOAK_REALM_RSA256_FINGERPRINT>` と置き換えて保存する。

```yaml
- OAUTH_SAML_IDP_CERT_FINGERPRINT=FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF
```

表示名を変更したい場合は `OAUTH_SAML_ATTRIBUTE_STATEMENTS_NAME` の値を割り当てたいKeycloakのマッパー設定の `SAML Attribute Name` の値に変更する。

```yaml
- OAUTH_SAML_ATTRIBUTE_STATEMENTS_NAME=name
```
