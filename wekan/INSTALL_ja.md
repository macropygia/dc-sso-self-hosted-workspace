# Wekan

## 管理者アカウントの作成方法

最初に作成したユーザーが自動的に管理者アカウントになる。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-wekan.json` をインポートし「保存」
2. 「クレデンシャル」タブを開き「シークレット」の内容をメモする (※1)
3. 表示名を変更したい場合は `トークンクレーム名` が `fullname` のマッパー設定を変更する

### docker-compose.yml

シークレットの文字列(※1)を `OAUTH2_SECRET` の `<KEYCLOAK_CLIENT_SECRET>` と置き換えて保存する。

```yaml
- OAUTH2_SECRET=abc12345-defg-6789-hijk-lmn0pqrstuvw
```
