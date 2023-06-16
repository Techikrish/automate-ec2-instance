#!/bin/bash

# Set your AWS region and instance details
AWS_REGION="us-east-1"
INSTANCE_TYPE="t2.micro"
AMI_ID="ami-12345678"
KEY_PAIR_NAME="your-key-pair-name"
SECURITY_GROUP_ID="sg-12345678"
SUBNET_ID="subnet-12345678"

# Launch the EC2 instance
INSTANCE_ID=$(aws ec2 run-instances --region $AWS_REGION \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_PAIR_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --output text --query 'Instances[0].InstanceId')

echo "Launched EC2 instance with ID: $INSTANCE_ID"

# Wait for the instance to be in the 'running' state
aws ec2 wait instance-running --region $AWS_REGION --instance-ids $INSTANCE_ID

echo "Instance $INSTANCE_ID is now running"

# Add any additional configuration or setup steps here, if needed

# Example: Retrieve the public IP address of the instance
PUBLIC_IP=$(aws ec2 describe-instances --region $AWS_REGION \
  --instance-ids $INSTANCE_ID \
  --output text --query 'Reservations[0].Instances[0].PublicIpAddress')

echo "Public IP address of the instance: $PUBLIC_IP"
