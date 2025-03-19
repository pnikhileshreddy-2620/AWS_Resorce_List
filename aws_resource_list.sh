#!/bin/bash

###############################################################################
# Author: Nikhilesh

# Script to list AWS resources in a given region
###############################################################################

# Check if the required number of arguments are passed
if [ $# -ne 2 ]; then
    echo "Usage: $0 <aws_region> <aws_service>"
    echo "Example: $0 us-east-1 ec2"
    exit 1
fi

# Assign arguments to variables
aws_region=$1
aws_service=$2

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it and try again."
    exit 1
fi

# Check if AWS CLI is configured
aws sts get-caller-identity &> /dev/null
if [ $? -ne 0 ]; then
    echo "AWS CLI is not properly configured. Please run 'aws configure' and try again."
    exit 1
fi

# List the resources based on the service
case $aws_service in
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region "$aws_region"
        ;;
    rds)
        echo "Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region "$aws_region"
        ;;
    s3)
        echo "Listing S3 Buckets"
        aws s3api list-buckets
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions"
        aws cloudfront list-distributions
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region "$aws_region"
        ;;
    iam)
        echo "Listing IAM Users"
        aws iam list-users
        ;;
    route53)
        echo "Listing Route53 Hosted Zones"
        aws route53 list-hosted-zones
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region "$aws_region"
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation describe-stacks --region "$aws_region"
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region "$aws_region"
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region "$aws_region"
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region "$aws_region"
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region "$aws_region"
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region "$aws_region"
        ;;
    *)
        echo "Invalid service: $aws_service. Please enter a valid AWS service."
        exit 1
        ;;
esac

