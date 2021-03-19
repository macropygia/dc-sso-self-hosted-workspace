# 各種リスト

## 対応アプリケーション

| 名称        | 種別                     |
| ----------- | ------------------------ |
| Keycloak    | SSO                      |
| GitLab      | Gitプラットフォーム      |
| Gitea       | Gitプラットフォーム      |
| CodiMD      | Markdownエディタ         |
| Wiki.js     | wiki                     |
| GROWI       | wiki                     |
| Mattermost  | チャットツール           |
| rocket.chat | チャットツール           |
| Wekan       | カンバン                 |
| TAIGA       | プロジェクト管理         |
| PENPOT      | デザインプロトタイピング |
| NextCloud   | クラウドストレージ       |

## 導入イメージ

| 名称          | 種別                     | Port   | Project Name  | Alias | Depends on     | Auth    |
| ------------- | ------------------------ | ------ | ------------- | ----- | -------------- | ------- |
| Keycloak      | SSO                      |        | keycloak      | kc    | pg             | ID/Pass |
| GitLab        | Gitプラットフォーム      |        | gitlab        |       | pg redis       | SAML    |
| Gitea         | Gitプラットフォーム      |        | gitea         |       | pg             | OIDC    |
| CodiMD        | Markdownエディタ         |        | codimd        |       | pg             | SAML    |
| Wiki.js       | wiki                     |        | wikijs        |       | pg es          | SAML    |
| GROWI         | wiki                     |        | growi         |       | mongo redis es | SAML    |
| Mattermost    | チャットツール           |        | mattermost    | mm    | pg             | GitLab  |
| rocket.chat   | チャットツール           |        | rocketchat    | rc    | mongo          | SAML    |
| Wekan         | カンバン                 |        | wekan         |       | mongo          | OIDC    |
| TAIGA         | プロジェクト管理         |        | taiga         |       | pg rmq         | GitLab  |
| PENPOT        | デザインプロトタイピング |        | penpot        |       | pg redis       | GitLab  |
| NextCloud     | クラウドストレージ       |        | nextcloud     | nc    | pg             | SAML    |
| pgAdmin       | PostgreSQL WebUI         |        | pgadmin       | pga   | pg             |         |
| phpMyAdmin    | MariaDB WebUI            |        | phpmyadmin    | pma   | maria          |         |
| mongo-express | MongoDB WebUI            |        | mongo_express | me    | mongo          |         |
| RedisInsight  | Redis WebUI              |        | redisinsight  | ri    | redis          |         |
| ElasticHQ     | Elasticsearch WebUI      |        | elastichq     | eshq  | es             |         |
| PostgreSQL    | RDBMS                    | 5432   | postgres      | pg    |                |         |
| MariaDB       | RDBMS                    | 3306   | mariadb       | maria |                |         |
| MongoDB       | NoSQL                    | 27017  | mongo         |       |                |         |
| Redis         | KVS                      | 6379   | redis         |       |                |         |
| RabbitMQ      | メッセージキューイング   | 5672   | rabbitmq      | rmq   |                |         |
| Elasticsearch | 全文検索                 | 9200   | elasticsearch | es    |                |         |
| nginx-proxy   | Reverse Proxy            | 80,443 | proxy         |       |                |         |
| MailCatcher   | ダミーSMTPサーバ         |        | mailcatcher   | mc    |                |         |
| Scope         | コンテナモニタリング     | 4040   | scope         |       |                |         |
| Portainer     | コンテナモニタリング     | 9000   | portainer     |       |                |         |

### 使用バージョン

| 名称          | Tag                 | Version                   | Override | Repository                                                               | Tags                                                                     |
| ------------- | ------------------- | ------------------------- | -------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
| Keycloak      | latest              | 12.0.4                    | config   | [quay.io](https://quay.io/repository/keycloak/keycloak)                  | [Link](https://quay.io/repository/keycloak/keycloak?tab=tags)            |
| GitLab        | latest              | 13.9.3-ce.0               |          | [dockerhub](https://hub.docker.com/r/gitlab/gitlab-ce)                   | [Link](https://hub.docker.com/r/gitlab/gitlab-ce/tags)                   |
| Gitea         | 1                   | 1.13.4                    |          | [dockerhub](https://hub.docker.com/r/gitea/gitea)                        | [Link](https://hub.docker.com/r/gitea/gitea/tags)                        |
| CodiMD        | latest              | 2.3.2                     |          | [dockerhub](https://hub.docker.com/r/hackmdio/hackmd)                    | [Link](https://hub.docker.com/r/hackmdio/hackmd/tags)                    |
| Wiki.js       | 2                   | 2.5.191                   |          | [dockerhub](https://hub.docker.com/r/requarks/wiki)                      | [Link](https://hub.docker.com/r/requarks/wiki/tags)                      |
| GROWI         | latest-nocdn        | 4.2.12-nocdn              |          | [dockerhub](https://hub.docker.com/r/weseek/growi)                       | [Link](https://hub.docker.com/r/weseek/growi/tags)                       |
| Mattermost    | latest              | 5.32.1                    |          | [dockerhub](https://hub.docker.com/r/mattermost/mattermost-team-edition) | [Link](https://hub.docker.com/r/mattermost/mattermost-team-edition/tags) |
| rocket.chat   | latest              | 3.12.1                    |          | [dockerhub](https://hub.docker.com/_/rocket-chat)                        | [Link](https://hub.docker.com/_/rocket-chat?tab=tags)                    |
| Wekan         | latest              | v5.05                     |          | [quay.io](https://quay.io/repository/wekan/wekan)                        | [Link](https://quay.io/repository/wekan/wekan?tab=tags)                  |
| TAIGA         | latest              | 6.x                       | source   | [dockerhub](https://hub.docker.com/u/taigaio)                            |                                                                          |
| PENPOT        | latest              | 1.3.0-alpha-1             | source   | [dockerhub](https://hub.docker.com/u/penpotapp)                          |                                                                          |
| NextCloud     | 21-apache           | 21.0.0-apache (21.0.0.18) | config   | [dockerhub](https://hub.docker.com/_/nextcloud)                          | [Link](https://hub.docker.com/_/nextcloud?tab=tags)                      |
| pgAdmin       | latest              | 5.0                       |          | [dockerhub](https://hub.docker.com/r/dpage/pgadmin4)                     | [Link](https://hub.docker.com/r/dpage/pgadmin4/tags)                     |
| phpMyAdmin    | latest              | 5.1.0-apache              |          | [dockerhub](https://hub.docker.com/_/phpmyadmin)                         | [Link](https://hub.docker.com/_/phpmyadmin?tab=tags)                     |
| mongo-express | latest              | 0.54.0                    |          | [dockerhub](https://hub.docker.com/_/mongo-express)                      | [Link](https://hub.docker.com/_/mongo-express?tab=tags)                  |
| RedisInsight  | latest              | 1.10.0                    |          | [dockerhub](https://hub.docker.com/r/redislabs/redisinsight)             | [Link](https://hub.docker.com/r/redislabs/redisinsight/tags)             |
| ElasticHQ     | latest              | v3.5.6                    |          | [dockerhub](https://hub.docker.com/r/elastichq/elasticsearch-hq)         | [Link](https://hub.docker.com/r/elastichq/elasticsearch-hq/tags)         |
| PostgreSQL    | 13-alpine           | 13.2-alpine               |          | [dockerhub](https://hub.docker.com/_/postgres)                           | [Link](https://hub.docker.com/_/postgres?tab=tags)                       |
| MariaDB       | 10                  | 10.5.9                    |          | [dockerhub](https://hub.docker.com/_/mariadb)                            | [Link](https://hub.docker.com/_/mariadb?tab=tags)                        |
| MongoDB       | 4-bionic            | 4.4.4-bionic              |          | [dockerhub](https://hub.docker.com/_/mongo)                              | [Link](https://hub.docker.com/_/mongo?tab=tags)                          |
| Redis         | 6-alpine            | 6.2.1-alpine              |          | [dockerhub](https://hub.docker.com/_/redis)                              | [Link](https://hub.docker.com/_/redis?tab=tags)                          |
| RabbitMQ      | 3-management-alpine | 3.8.14-management-alpine  |          | [dockerhub](https://hub.docker.com/_/rabbitmq)                           | [Link](https://hub.docker.com/_/rabbitmq?tab=tags)                       |
| Elasticsearch | 6.8.14              | 6.8.14                    |          | [elasticsearch](https://www.docker.elastic.co/r/elasticsearch)           | [Link](https://www.docker.elastic.co/r/elasticsearch)                    |
| nginx-proxy   | alpine              | 0.8.0                     | source   | [dockerhub](https://hub.docker.com/r/jwilder/nginx-proxy)                | [Link](https://hub.docker.com/r/jwilder/nginx-proxy/tags)                |
| MailCatcher   | latest              |                           |          | [dockerhub](https://hub.docker.com/r/sj26/mailcatcher)                   | [Link](https://hub.docker.com/r/sj26/mailcatcher/tags)                   |
| Scope         | latest_release      | 1.13.1                    |          | [dockerhub](https://hub.docker.com/r/weaveworks/scope)                   | [Link](https://hub.docker.com/r/weaveworks/scope/tags)                   |
| Portainer     | alpine              | 1.24.1-alpine             |          | [dockerhub](https://hub.docker.com/r/portainer/portainer)                | [Link](https://hub.docker.com/r/portainer/portainer/tags)                |

- Version
    - 動作を確認したバージョン
- Override
    - イメージ内のファイルをvolumesで上書きしているかどうか
    - バージョンが変わると問題が生じる可能性が高い（特にソースを書き換えているもの）
- 注
    - rocket.chat
        - MongoDB 4.0までしか対応していないが4.4で動作させている
    - PENPOT
        - まだAlpha版

## URL

SSL有効/ドメイン `shw.test` /ローカルIPアドレス `192.168.1.234` の場合

| 名称          | URL                                | 備考                |
| ------------- | ---------------------------------- | ------------------- |
| Keycloak      | https://auth.shw.test              |                     |
| GitLab        | https://gitlab.shw.test            |                     |
| Gitea         | https://gitea.shw.test             |                     |
| CodiMD        | https://codimd.shw.test            |                     |
| Wiki.js       | https://wikijs.shw.test            |                     |
| GROWI         | https://growi.shw.test             |                     |
| Mattermost    | https://mm.shw.test                |                     |
| rocket.chat   | https://rc.shw.test                |                     |
| Wekan         | https://wekan.shw.test             |                     |
| TAIGA         | https://taiga.shw.test             |                     |
| ^             | https://taiga.shw.test/admin/      | 管理画面            |
| PENPOT        | https://penpot.shw.test            |                     |
| NextCloud     | https://nc.shw.test                |                     |
| ^             | https://nc.shw.test/login?direct=1 | ID/Passログイン画面 |
| pgAdmin       | http://pga.shw.test                |                     |
| phpMyAdmin    | http://pma.shw.test                |                     |
| mongo-express | http://me.shw.test                 |                     |
| RedisInsight  | http://ri.shw.test                 |                     |
| ElasticHQ     | http://eshq.shw.test               |                     |
| PostgreSQL    | N/A                                |                     |
| MariaDB       | N/A                                |                     |
| MongoDB       | N/A                                |                     |
| Redis         | N/A                                |                     |
| RabbitMQ      | http://rmq.shw.test                |                     |
| Elasticsearch | N/A                                |                     |
| nginx-proxy   | N/A                                |                     |
| MailCatcher   | http://mc.shw.test                 |                     |
| Scope         | http://192.168.1.234:4040          |                     |
| Portainer     | http://192.168.1.234:9000          |                     |

## Volumes

- codimd-uploads
- elasticsearch-data
- gitea-data
- gitlab-data
- gitlab-logs
- gitlab-node_modules
- growi-data
- maria-data
- mattermost-client-plugins
- mattermost-config
- mattermost-data
- mattermost-indexes
- mattermost-logs
- mattermost-plugins
- mongo-config
- mongo-data
- mongo-repl-config
- mongo-repl-data
- nextcloud-apps
- nextcloud-data
- nextcloud-main
- penpot-data
- pgadmin-data
- portainer-data
- postgres-data
- proxy-dhparam
- rabbitmq-data
- redis-data
- redisinsight-data
- rocketchat-uploads
- taiga-media-data
- taiga-static-data
- wikijs-content
