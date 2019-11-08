# debug-tools

Upgrade based on `https://github.com/nicolaka/netshoot.git` project .

And, I've added some commonly used debug tools, such as redis-cli , mysql, java( jps, jstack, jmap, jinfo...) ,jq...


```bash
docker run -it —-network=container:<container_ID> -—pid=container:<container_ID> -—ipc=container:<container_ID> liyongjian5179:debug-tools 
```
