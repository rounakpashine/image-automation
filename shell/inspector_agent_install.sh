#!/bin/bash

echo "*******Installing AWS Inspector Agent********"
curl -o "/tmp/inspector_install" https://inspector-agent.amazonaws.com/linux/latest/install

sudo bash /tmp/inspector_install

sudo /etc/init.d/awsagent start

sudo /etc/init.d/awsagent status

python python/execute_aws_inspector.py
