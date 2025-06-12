#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-068450c7fc6b1022d"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z00631643FZP9GXC6CVLE"
DOMAIN_NAME="daws84s.xyz"

for instance in ${INSTANCES[@]}
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-068450c7fc6b1022d --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=test}]' --query 'Instances[0].InstanceId' --output text)
    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instance IP address: $IP"

done