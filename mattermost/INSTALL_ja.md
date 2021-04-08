# Mattermost

## 管理者アカウントの作成方法

最初に作成したユーザーが自動的に管理者アカウントになる。

## SSO設定

### Keycloak管理画面

1. 左メニューから「クライアント」→「作成」→「ファイルを選択」から `keycloak/client_settings/app-mattermost-oicd.json` をインポートし「保存」
2. 「クレデンシャル」タブを開き「シークレット」の内容をメモする (※1)
3. 表示名を変更したい場合は `トークンクレーム名` が `name` のマッパー設定を変更する

#### スクリプトマッパー

トークンクレーム名 `id` でGitLabのユーザーID（ユニークな整数）に相当する内容を渡す必要があるため、KeycloakのユーザーID（UUID v4）から16桁の整数を自動生成するスクリプトマッパーを使用する。

詳細は[Qiita記事](https://qiita.com/macropygia/items/02eb4da2120cb30032b2)を参照のこと。

- `keycloak/mount/profile.properties`
    - スクリプトマッパーを有効にするためのKeycloak設定ファイル
- `keycloak/mount/uuid-to-int48-mapper.jar`
    - スクリプトマッパーとメタデータをまとめたjarファイル
- `keycloak/mapper/*`
    - スクリプトマッパーのソースとjar用のメタデータ

### docker-compose.yml

シークレットの文字列(※1)を `MM_GITLABSETTINGS_SECRET` の `<KEYCLOAK_CLIENT_SECRET>` と置き換えて保存する。

```yaml
- MM_GITLABSETTINGS_SECRET=abc12345-defg-6789-hijk-lmn0pqrstuvw
```
