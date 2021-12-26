# go-dialer

Simple dockerized FS

Configuration files are located in the conf folder.

## MAKE Options 

### Build 

```
build:
	@echo "Building FS ..."
	/usr/bin/docker build -t freeswitch .
```
### Run 

```
run:
	@echo "Running ..."
	/usr/bin/docker run --name freeswitch -p 127.0.0.1:5070:5070/udp -p 127.0.0.1:64600-64605:64600-64605/udp -d freeswitch:latest
```
### Stop

```
stop:
	@echo "Stopping ..."
	/usr/bin/docker stop freeswitch
	/usr/bin/docker rm freeswitch
```

### FSCli 
```
fscli:
	@echo "Running fs_cli on container ..."
	/usr/bin/docker  exec -it freeswitch fs_cli
```

### SNGREP

```
sngrep:
	@echo "Running sngrep on container ..."
	/usr/bin/docker  exec -it freeswitch sngrep
```

### Log

```
log:
	@echo "Running sngrep on container ..."
	/usr/bin/docker  exec -it freeswitch tail -f /var/log/syslog
```
