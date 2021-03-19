# Mattermost

## 管理者アカウントの作成方法

最初に作成したユーザーが自動的に管理者アカウントになる。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-mattermost-oicd.json` をインポートし「保存」
2. 「クレデンシャル」タブを開き「シークレット」の内容をメモする (※1)
3. 表示名を変更したい場合は `トークンクレーム名` が `name` のマッパー設定を変更する

#### 専用属性

各ユーザーにユニークな整数のユーザー属性が必要になる。
同梱のクライアント設定では `longId` という名前に設定している。

1. 左メニューから「ユーザー」→「すべてのユーザーを参照」→任意のユーザーを「編集」→「属性」
2. キー `longId` → 値 `<整数>` →「追加」→「保存」

### docker-compose.yml

シークレットの文字列(※1)を `MM_GITLABSETTINGS_SECRET` の `<KEYCLOAK_CLIENT_SECRET>` と置き換えて保存する。

```yaml
- MM_GITLABSETTINGS_SECRET=abc12345-defg-6789-hijk-lmn0pqrstuvw
```
