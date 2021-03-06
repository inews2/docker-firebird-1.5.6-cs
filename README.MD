# Firebird Dockerfile

## Description

Firebird 1.5.6 Classic

### Provides

  Firebird SQL relational database (http://www.firebirdsql.org/).

### Volumes

 * /backup
 * /data
 * /opt/firebird

### Exposed Ports

 * 3050

### Env

 * TZ // You can set timezone for your docker container via this variable, if not specified then its default value is "Etc/UTC"

for example add "-e Europe/Sarajevo" to your docker run command.

### Firebird credentials

 * Username: SYSDBA
 * Password: masterkey

## Run

	$ docker run -d \
		--name firebird \	
		-p 3050:3050 \
		-v /somehostdir/firebird/backup/:/backup/ \
		-v /somehostdir/firebird/data/:/data/ \
		inews2/firebird1.5.6-cs

## Misc

### Restore backup

	//enter container console
	$ docker exec -i -t firebird /bin/bash

    //backup
    $ gbak -v -t -user SYSDBA -password masterkey localhost:/data/dbname.fdb /backup/dbname.fbk 

     //restore 
	$ gbak -c -v -user SYSDBA -password masterkey /backup/dbname.fbk localhost:/data/dbname.fdb
