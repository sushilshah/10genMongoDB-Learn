set mongod=start /MIN mongod
set mongos=start /MIN mongos
set name=%COMPUTERNAME%

mkdir a0
mkdir a1
mkdir a2
mkdir b0
mkdir b1
mkdir b2
mkdir c0
mkdir c1
mkdir c2
mkdir d0
mkdir d1
mkdir d2

mkdir cfg0
mkdir cfg1
mkdir cfg2

rem config servers
%mongod% --configsvr --dbpath cfg0 --port 26050 --logpath log.cfg0 --logappend
%mongod% --configsvr --dbpath cfg1 --port 26051 --logpath log.cfg1 --logappend
%mongod% --configsvr --dbpath cfg2 --port 26052 --logpath log.cfg2 --logappend

rem "sahrd server" (mongod data servers)
rem note: don't use smallfiles nor such a small oplogSize in producation; these are here running on one machine

%mongod% --shardsvr --replSet a --dbpath a0 --logpath log.a0 --port 27000 --logappend --smallfiles --oplogSize 50
%mongod% --shardsvr --replSet a --dbpath a1 --logpath log.a1 --port 27001 --logappend --smallfiles --oplogSize 50
%mongod% --shardsvr --replSet a --dbpath a2 --logpath log.a2 --port 27002 --logappend --smallfiles --oplogSize 50

%mongod% --shardsvr --replSet b --dbpath b0 --logpath log.b0 --port 27100 --logappend --smallfiles --oplogSize 50
%mongod% --shardsvr --replSet b --dbpath b1 --logpath log.b1 --port 27101 --logappend --smallfiles --oplogSize 50
%mongod% --shardsvr --replSet b --dbpath b2 --logpath log.b2 --port 27102 --logappend --smallfiles --oplogSize 50

%mongod% --shardsvr --replSet c --dbpath c0 --logpath log.c0 --port 27200 --logappend --smallfiles --oplogSize 50
%mongod% --shardsvr --replSet c --dbpath c1 --logpath log.c1 --port 27201 --logappend --smallfiles --oplogSize 50
%mongod% --shardsvr --replSet c --dbpath c2 --logpath log.c2 --port 27202 --logappend --smallfiles --oplogSize 50

%mongod% --shardsvr --replSet d --dbpath d0 --logpath log.d0 --port 27300 --logappend --smallfiles --oplogSize 50
%mongod% --shardsvr --replSet d --dbpath d1 --logpath log.d1 --port 27301 --logappend --smallfiles --oplogSize 50
%mongod% --shardsvr --replSet d --dbpath d2 --logpath log.d2 --port 27302 --logappend --smallfiles --oplogSize 50

rem mongos process

%mongos% --configdb %name%:26050,%name%:26051,%name%:26052 --logappend --logpath log.mongos0
%mongos% --configdb %name%:26050,%name%:26051,%name%:26052 --logappend --logpath log.mongos1 --port 26061
%mongos% --configdb %name%:26050,%name%:26051,%name%:26052 --logappend --logpath log.mongos2 --port 26062
%mongos% --configdb %name%:26050,%name%:26051,%name%:26052 --logappend --logpath log.mongos3 --port 26063
