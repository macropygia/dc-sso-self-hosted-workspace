# nginx-proxy

## アップロード容量制限

以下のファイルを編集し `client_max_body_size` を設定する。

- `mount/conf.d/00_common.conf`
    - httpディレクティブ共通の設定
    - 標準では `client_max_body_size` を100MBに、 `client_body_buffer_size` を1MBに設定してある
        - `client_body_buffer_size` が小さい（nginx標準では16KB）と一部アプリの通常操作でもリクエストボディをディスクに書き出す旨のwarningが発生するため、その閾値を1MBに引き上げている
            - 1MBは各種ツールへの画像の添付を想定した値
        - ファイルのアップロード等でリクエストボディの容量が1MBを超える場合は引き続きwarningが発生する
            - warningの発生を止めたい場合などは個別に設定内容を検討のこと
- `mount/vhost.d/*_location`
    - 各ドメインのlocationディレクティブにおける設定
    - 例としてNextCloudは `client_max_body_size` を1GBに設定し、 `proxy_request_buffering` をオフにしてある
        - 動作環境の都合で `proxy_request_buffering` がオフにできない場合に備えて、バッファを常にディスクに書き出す `client_body_in_file_only` の設定も行っている

## 多段プロキシ時のRealIP設定

- `optional/proxy.conf` の `<PROXY_IP>` をプロキシサーバのIPに差し替えて `mount/proxy.conf` に移動ないしコピーする
- `docker-compose.yml` の `volumes` セクションで `proxy.conf` の差替を有効にする
