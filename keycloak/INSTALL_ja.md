# Keycloak

## 管理者アカウントの作成方法

`docker-compose.yml` の `environment` で作成する。

```yaml
- KEYCLOAK_USER=webmaster
- KEYCLOAK_PASSWORD=Pa55w@rd
```

## セットアップ

アプリケーション毎の設定を開始する前に実施するもの。
docker-compose.ymlで設定した管理者アカウントでログインする。

### 日本語化

1. 左メニューから「Realm Serrings」→「Themes」
2. 「Internationalization Enabled」をON
3. 「Default Locale」を `ja` にして「Save」
4. 左メニューから「Users」→「View all users」→ID列のリンク
5. 「Locale」を `ja` に変更して「Save」ボタンを押す
6. リロードすると日本語UIで表示される

### レルムの作成

1. 管理画面左上のレルム名マウスオーバーから「レルムの追加」
2. `setup/.env` で設定した名前を入力
3. 「作成」ボタンを押す
4. コンテンツカラムのタブから「テーマ」→「国際化の有効」をオン
5. デフォルト・ロケールを `ja` に変更して「保存」ボタンを押す

#### GitLab偽装用スコープの作成

TAIGAとPENPOTを使用する場合は必須。

1. 左メニューから「クライアント・スコープ」→「作成」ボタンを押す
2. 「名前」に `read_user` と入力して「保存」ボタンを押す

### テスト用ユーザーの作成

1. 左メニューから「ユーザー」→「ユーザーの追加」ボタンを押す
2. 「ユーザー名」「Eメール」「名」「姓」を入力する
3. 任意で「Eメールが確認済」をオン
4. 「ロケール」を `ja` に変更して「保存」ボタンを押す
5. コンテンツエリアのタブから「属性」
6. キー列の入力欄に `displayName` 、値列の入力欄に各アプリの表示名に使用する任意の文字列を入力して「追加」ボタンを押す
7. キー列の入力欄に `longId` 、値列の入力欄に半角数字で任意の整数を入力して「追加」ボタンを押す（他のユーザーと重複不可, 1桁前半は避けた方がよい, Mattermostを使用しないなら不要）
8. 「保存」ボタンを押す

ここで設定する「ユーザー名」「Eメール」「名」「姓」は **ユーザープロパティ（User Property）** となり、「ロケール」「displayName」「longId」は **ユーザー属性（User Attribute）** となる。
いずれもクライアント設定のマッピングで使用できる。

| 日本語UI上の名称 | 種別           | キー名      |                                    |
| ---------------- | -------------- | ----------- | ---------------------------------- |
| ユーザー名       | User Property  | username    | 半角英数記号, 重複不可, 変更不可   |
| Eメール          | User Property  | email       | メールアドレス, 重複不可           |
| 名               | User Property  | firstName   |                                    |
| 姓               | User Property  | lastName    |                                    |
| ロケール         | User Attribute | locale      | 言語コード                         |
|                  | User Attribute | displayName |                                    |
|                  | User Attribute | longId      | 半角数字, 整数, 重複不可, 変更不可 |

※firstNameとlastNameにCJK文字を使用できるかどうかはアプリケーションの実装による
