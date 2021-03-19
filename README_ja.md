# Self-hosted Workspace

[ [English](README.md) | 日本語 ]

docker-compose製Web開発用SSOオンプレブラウザアプリ統合環境

![scope](https://user-images.githubusercontent.com/3162324/111616182-f37a2280-8824-11eb-9aaa-9f89e0b3c001.png)

- RHEL8互換環境向け
- インストール方法は [docs/INSTALL_ja.md](docs/INSTALL_ja.md) と各ディレクトリの `INSALL_ja.md` を参照のこと

## 対応イメージ

| Name                                                                  | Type                       |
| --------------------------------------------------------------------- | -------------------------- |
| [Keycloak](https://www.keycloak.org/)                                 | SSO                        |
| [GitLab](https://about.gitlab.com/)                                   | Gitプラットフォーム        |
| [Gitea](https://gitea.io/)                                            | Gitプラットフォーム        |
| [CodiMD](https://github.com/hackmdio/codimd)                          | Markdownエディタ           |
| [Wiki.js](https://js.wiki/)                                           | Wiki                       |
| [GROWI](https://growi.org/)                                           | Wiki                       |
| [Mattermost](https://mattermost.com/)                                 | チャット                   |
| [rocket.chat](https://rocket.chat/)                                   | チャット                   |
| [Wekan](https://wekan.github.io/)                                     | カンバン                   |
| [TAIGA](https://www.taiga.io/)                                        | プロジェクト管理           |
| [PENPOT](https://penpot.app/)                                         | デザインプロトタイピング   |
| [NextCloud](https://nextcloud.com/)                                   | クラウドストレージ         |
| [PostgreSQL](https://www.postgresql.org/)                             | RDBMS                      |
| [MariaDB](https://mariadb.com/)                                       | RDBMS                      |
| [MongoDB](https://www.mongodb.com/)                                   | NoSQL                      |
| [Redis](https://redis.io/)                                            | KVS                        |
| [Elasticsearch](https://www.elastic.co/elasticsearch/)                | 検索エンジン               |
| [RabbitMQ](https://www.rabbitmq.com/)                                 | メッセージキュー           |
| [pgAdmin](https://www.pgadmin.org/)                                   | PostgreSQL WebUI           |
| [phpMyAdmin](https://www.phpmyadmin.net/)                             | MariaDB WebUI              |
| [mongo-express](https://github.com/mongo-express/mongo-express)       | MongoDB WebUI              |
| [RedisInsight](https://redislabs.com/redis-enterprise/redis-insight/) | Redis WebUI                |
| [ElasticHQ](https://www.elastichq.org/)                               | Elasticsearch WebUI        |
| [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy)             | リバースプロキシ           |
| [MailCatcher](https://mailcatcher.me/)                                | ダミーSMTPサーバ           |
| [Scope](https://www.weave.works/oss/scope/)                           | コンテナモニタリング       |
| [Portainer](https://www.portainer.io/)                                | コンテナモニタリング・管理 |

## Makefileの使用法

ref. https://github.com/macropygia/dc-multiple-project-makefile/blob/main/README_ja.md
