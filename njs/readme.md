```bash
docker run -p 9999:9999 -v $(pwd)/ja3.js:/etc/nginx/ja3.js -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf -it --rm nginx
```

```bash
curl -v localhost:9999 -H 'X-Qrator-Cl-Ssl-Params: 0304,6a6a:1301:1302:1303:c02c:c02b:cca9:c030:c02f:cca8:c00a:c009:c014:c013,0000:0017:ff01:000a:000b:0010:0005:000d:0012:0033:002d:002b:001b:0015,dada:001d:0017:0018:0019,'```
