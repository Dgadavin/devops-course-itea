# Usefull command

```bash
ES_HOST=""
curl ${ES_HOST}

curl ${ES_HOST}/_cat/health?v

curl ${ES_HOST}/_cat/indices?v

curl -X POST ${ES_HOST}/monitor/logs?pretty -d '{
 "kind": "info",
 "message": "The server is up and running"
}'

curl ${ES_HOST}/monitor/_search?pretty
```
