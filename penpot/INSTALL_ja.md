# PENPOT

## 管理者アカウントの作成方法

管理者アカウントは存在しない。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-penpot.json` をインポートし「保存」
2. 「クレデンシャル」タブを開き「シークレット」の内容をメモする (※1)
3. 表示名を変更したい場合は `トークンクレーム名` が `name` のマッパー設定を変更する（`トークンクレーム名` が `fullname` のマッパー設定は削除しないこと）

### docker-compose.yml

シークレットの文字列(※1)を `PENPOT_GITLAB_CLIENT_SECRET` の `<KEYCLOAK_CLIENT_SECRET>` と置き換えて保存する。

```yaml
- PENPOT_GITLAB_CLIENT_SECRET=abc12345-defg-6789-hijk-lmn0pqrstuvw
```
