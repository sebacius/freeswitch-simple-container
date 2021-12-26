.DEFAULT_GOAL := all

build:
	@echo "Building FS ..."
	/usr/bin/docker build -t freeswitch .

run:
	@echo "Running ..."
	/usr/bin/docker run --name freeswitch -p 127.0.0.1:5070:5070/udp -p 127.0.0.1:64600-64605:64600-64605/udp -d freeswitch:latest

stop:
	@echo "Stopping ..."
	/usr/bin/docker stop freeswitch
	/usr/bin/docker rm freeswitch

fscli:
	@echo "Running fs_cli on container ..."
	/usr/bin/docker  exec -it freeswitch fs_cli

sngrep:
	@echo "Running sngrep on container ..."
	/usr/bin/docker  exec -it freeswitch sngrep

log:
	@echo "Running sngrep on container ..."
	/usr/bin/docker  exec -it freeswitch tail -f /var/log/syslog
