# nginx-proxy

## 多段プロキシ時のRealIP設定

- `optional/proxy.conf` の `<PROXY_IP>` をプロキシサーバのIPに差し替えて `mount/proxy.conf` に移動ないしコピーする
- `docker-compose.yml` の `volumes` セクションで `proxy.conf` の差替を有効にする
