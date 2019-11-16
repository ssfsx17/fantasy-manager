# Infra

## Design

Only one public VPC per region, responsible for holding the Internet and NAT gateways. This is in order to fit into [AWS account limits](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html). All private VPCs get internet access through the one public VPC in the same region.

## Preparation

Assumes you have an S3 bucket with encryption and versioning enabled, named `tfstate`.

Otherwise, you can create the bucket as follows:
```
export INFRA_BUCKET_NAME=x17-infra

aws s3api create-bucket \
  --acl private \
  --bucket ${INFRA_BUCKET_NAME}

aws s3api put-bucket-acl \
  --acl private \
  --bucket ${INFRA_BUCKET_NAME}

aws s3api put-bucket-encryption \
  --bucket ${INFRA_BUCKET_NAME} \
  --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'

aws s3api put-bucket-versioning \
  --bucket ${INFRA_BUCKET_NAME} \
  --versioning-configuration Status=Enabled
```
