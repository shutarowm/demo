#!/bin/sh

cd /home/ec2-user/app
nohup java -jar demo-0.0.1-SNAPSHOT.jar > log.txt 2> error.txt &