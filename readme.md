```bash
docker run -p 9999:9999 -v $(pwd)/ja3.lua:/etc/nginx/lua/ja3.lua -v $(pwd)/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf -it --rm openresty/openresty:1.15.8.3-0-alpine
```

```bash
curl -v localhost:9999 -H 'hui=0304,6a6a:1301:1302:1303:c02c:c02b:cca9:c030:c02f:cca8:c00a:c009:c014:c013,0000:0017:ff01:000a:000b:0010:0005:000d:0012:0033:002d:002b:001b:0015,dada:001d:0017:0018:0019,'
```