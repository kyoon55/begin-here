#!/bin/bash

# Do command: sh ~/Desktop/projects/update-aws-access-key.sh access-key secret-key

cat << EOF > ~/.aws/credentials
[default]
aws_access_key_id=$1
aws_secret_access_key=$2

[west]
aws_access_key_id=$1
aws_secret_access_key=$2
region=us-west-2
EOF

# Get caller identity
aws sts get-caller-identity
rm -rf ~/projects/Dev.pem

# Add a key pair
aws ec2 create-key-pair \
    --key-name Dev \
    --key-type rsa \
    --key-format pem \
    --query "KeyMaterial" \
    --output text > ~/projects/Dev.pem

aws ec2 create-key-pair \
    --key-name Dev \
    --key-type rsa \
    --key-format pem \
    --query "KeyMaterial" \
    --output text \
    --profile west


chmod 400 ~/projects/Dev.pem
#aws ec2 import-key-pair --key-name Dev --public-key-material fileb://~/.ssh/id_rsa.pub                         
