#!/bin/bash

set -u

ACCOUNT=$(aws sts get-caller-identity --query Account --output text)

echo "========================================"
echo " AWS ACCOUNT: $ACCOUNT"
echo "========================================"

REGIONS=$(aws ec2 describe-regions \
  --query 'Regions[].RegionName' \
  --output text)

for REGION in $REGIONS; do

    echo
    echo "########################################"
    echo "# REGION: $REGION"
    echo "########################################"

    echo
    echo "---- EC2 INSTANCES ----"
    aws ec2 describe-instances \
      --region "$REGION" \
      --query 'Reservations[].Instances[].[InstanceId,State.Name,InstanceType]' \
      --output table

    echo
    echo "---- VPCs ----"
    aws ec2 describe-vpcs \
      --region "$REGION" \
      --query 'Vpcs[].[VpcId,CidrBlock,IsDefault]' \
      --output table

    echo
    echo "---- SUBNETS ----"
    aws ec2 describe-subnets \
      --region "$REGION" \
      --query 'Subnets[].[SubnetId,VpcId,CidrBlock,AvailabilityZone]' \
      --output table

    echo
    echo "---- NAT GATEWAYS ----"
    aws ec2 describe-nat-gateways \
      --region "$REGION" \
      --filter Name=state,Values=available,pending,deleting \
      --query 'NatGateways[].[NatGatewayId,State,VpcId,SubnetId]' \
      --output table

    echo
    echo "---- ELASTIC IPS ----"
    aws ec2 describe-addresses \
      --region "$REGION" \
      --query 'Addresses[].[AllocationId,PublicIp,AssociationId,InstanceId]' \
      --output table

    echo
    echo "---- LOAD BALANCERS ----"
    aws elbv2 describe-load-balancers \
      --region "$REGION" \
      --query 'LoadBalancers[].[LoadBalancerName,Type,State.Code,VpcId]' \
      --output table

    echo
    echo "---- EKS ----"
    aws eks list-clusters \
      --region "$REGION" \
      --output table

    echo
    echo "---- RDS ----"
    aws rds describe-db-instances \
      --region "$REGION" \
      --query 'DBInstances[].[DBInstanceIdentifier,DBInstanceStatus,Engine]' \
      --output table

    echo
    echo "---- EBS VOLUMES ----"
    aws ec2 describe-volumes \
      --region "$REGION" \
      --query 'Volumes[].[VolumeId,State,Size,VolumeType,Attachments[0].InstanceId]' \
      --output table

    echo
    echo "---- EBS SNAPSHOTS (OWNED BY ACCOUNT) ----"
    aws ec2 describe-snapshots \
      --region "$REGION" \
      --owner-ids "$ACCOUNT" \
      --query 'Snapshots[].[SnapshotId,State,VolumeSize,StartTime,Description]' \
      --output table

    echo
    echo "---- LAMBDA ----"
    aws lambda list-functions \
      --region "$REGION" \
      --query 'Functions[].[FunctionName,Runtime]' \
      --output table

    echo
    echo "---- ECR ----"
    aws ecr describe-repositories \
      --region "$REGION" \
      --query 'repositories[].[repositoryName,repositoryUri]' \
      --output table

    echo
    echo "---- CLOUDWATCH LOG GROUPS ----"
    aws logs describe-log-groups \
      --region "$REGION" \
      --query 'logGroups[].[logGroupName,storedBytes]' \
      --output table

done

echo
echo "========================================"
echo " GLOBAL RESOURCES"
echo "========================================"

echo
echo "---- S3 BUCKETS ----"
aws s3api list-buckets \
  --query 'Buckets[].[Name,CreationDate]' \
  --output table

echo
echo "---- IAM USERS ----"
aws iam list-users \
  --query 'Users[].[UserName,Arn]' \
  --output table

echo
echo "---- IAM ROLES ----"
aws iam list-roles \
  --query 'Roles[].[RoleName,Arn]' \
  --output table

echo
echo "---- ROUTE53 HOSTED ZONES ----"
aws route53 list-hosted-zones \
  --query 'HostedZones[].[Name,Id]' \
  --output table

echo
echo "---- CLOUDFORMATION STACKS ----"
aws cloudformation list-stacks \
  --stack-status-filter \
    CREATE_IN_PROGRESS \
    CREATE_COMPLETE \
    UPDATE_IN_PROGRESS \
    UPDATE_COMPLETE \
    UPDATE_ROLLBACK_COMPLETE \
    DELETE_FAILED \
  --query 'StackSummaries[].[StackName,StackStatus]' \
  --output table

echo
echo "========================================"
echo " INVENTORY FINISHED"
echo "========================================"
