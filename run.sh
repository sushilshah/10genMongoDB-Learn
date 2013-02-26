
# sushil 
# 02/27/2013
#setting up replica set, shard server, config server of mongodb
mkdir /opt/testdata/data/db/a0
mkdir /opt/testdata/data/db/a1
mkdir /opt/testdata/data/db/a2
mkdir /opt/testdata/data/db/b0
mkdir /opt/testdata/data/db/b1
mkdir /opt/testdata/data/db/b2
mkdir /opt/testdata/data/db/c0
mkdir /opt/testdata/data/db/c1
mkdir /opt/testdata/data/db/c2
mkdir /opt/testdata/data/db/d0
mkdir /opt/testdata/data/db/d1
mkdir /opt/testdata/data/db/d2

mkdir /opt/testdata/data/db/cfg0
mkdir /opt/testdata/data/db/cfg1
mkdir /opt/testdata/data/db/cfg2

# rem config servers
# --fork --logpath a.log
./mongod --configsvr --fork --dbpath /opt/testdata/data/db/cfg0 --port 26050 --logpath /opt/testdata/data/db/logs/log.cfg0 --logappend
./mongod --configsvr --fork --dbpath /opt/testdata/data/db/cfg1 --port 26051 --logpath /opt/testdata/data/db/logs/log.cfg1 --logappend
./mongod --configsvr --fork --dbpath /opt/testdata/data/db/cfg2 --port 26052 --logpath /opt/testdata/data/db/logs/log.cfg2 --logappend

# rem "sahrd server" (mongod data servers)
# rem note: don't use smallfiles nor such a small oplogSize in producation; these are here running on one machine

./mongod --shardsvr --fork --replSet a --dbpath /opt/testdata/data/db/a0 --logpath /opt/testdata/data/db/logs/log.a0 --port 27000 --logappend --smallfiles --oplogSize 50
./mongod --shardsvr --fork --replSet a --dbpath /opt/testdata/data/db/a1 --logpath /opt/testdata/data/db/logs/log.a1 --port 27001 --logappend --smallfiles --oplogSize 50
./mongod --shardsvr --fork --replSet a --dbpath /opt/testdata/data/db/a2 --logpath /opt/testdata/data/db/logs/log.a2 --port 27002 --logappend --smallfiles --oplogSize 50

./mongod --shardsvr --fork --replSet b --dbpath /opt/testdata/data/db/b0 --logpath /opt/testdata/data/db/logs/log.b0 --port 27100 --logappend --smallfiles --oplogSize 50
./mongod --shardsvr --fork --replSet b --dbpath /opt/testdata/data/db/b1 --logpath /opt/testdata/data/db/logs/log.b1 --port 27101 --logappend --smallfiles --oplogSize 50
./mongod --shardsvr --fork --replSet b --dbpath /opt/testdata/data/db/b2 --logpath /opt/testdata/data/db/logs/log.b2 --port 27102 --logappend --smallfiles --oplogSize 50

./mongod --shardsvr --fork --replSet c --dbpath /opt/testdata/data/db/c0 --logpath /opt/testdata/data/db/logs/log.c0 --port 27200 --logappend --smallfiles --oplogSize 50
./mongod --shardsvr --fork --replSet c --dbpath /opt/testdata/data/db/c1 --logpath /opt/testdata/data/db/logs/log.c1 --port 27201 --logappend --smallfiles --oplogSize 50
./mongod --shardsvr --fork --replSet c --dbpath /opt/testdata/data/db/c2 --logpath /opt/testdata/data/db/logs/log.c2 --port 27202 --logappend --smallfiles --oplogSize 50

./mongod --shardsvr --fork --replSet d --dbpath /opt/testdata/data/db/d0 --logpath /opt/testdata/data/db/logs/log.d0 --port 27300 --logappend --smallfiles --oplogSize 50
./mongod --shardsvr --fork --replSet d --dbpath /opt/testdata/data/db/d1 --logpath /opt/testdata/data/db/logs/log.d1 --port 27301 --logappend --smallfiles --oplogSize 50
./mongod --shardsvr --fork --replSet d --dbpath /opt/testdata/data/db/d2 --logpath /opt/testdata/data/db/logs/log.d2 --port 27302 --logappend --smallfiles --oplogSize 50

# rem mongos process

./mongos --configdb ip-10-0-2-98:26050,ip-10-0-2-98:26051,ip-10-0-2-98:26052 --fork --logappend --logpath /opt/testdata/data/db/logs/log.mongos0
./mongos --configdb ip-10-0-2-98:26050,ip-10-0-2-98:26051,ip-10-0-2-98:26052 --fork --logappend --logpath /opt/testdata/data/db/logs/log.mongos1 --port 26061
./mongos --configdb ip-10-0-2-98:26050,ip-10-0-2-98:26051,ip-10-0-2-98:26052 --fork --logappend --logpath /opt/testdata/data/db/logs/log.mongos2 --port 26062
./mongos --configdb ip-10-0-2-98:26050,ip-10-0-2-98:26051,ip-10-0-2-98:26052 --fork --logappend --logpath /opt/testdata/data/db/logs/log.mongos3 --port 26063
