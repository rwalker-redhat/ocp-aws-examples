# ocp-aws-examples

This repo holds documentation and examples for deploying code on OpenShift 4.x and AWS to use as comparisons. 

This README.md contains the essential notes on working with the examples in this repo, however the examples includes a static website using Pythons MkDocs that in itself contains more detailed documentation. 

# Client Tools

All work is done using a Red Hat Enterprise Linux 8 client. 

## AWS CLI tool

Download the `aws-cli` tool

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

```
aws --version
aws-cli/2.4.27 Python/3.8.8 Linux/4.18.0-348.12.2.el8_5.x86_64 exe/x86_64.rhel.8 prompt/off
```

These guides assume a valid AWS user with both an Access key for programmatic access and AWS management console access with an attached existing policy `AdministratorAccess`. Therefore, the following commands configure your local environment using your AWS user access and secret keys. Moreover, by specifying a profile you can use multiple credentials on the same client.  

```
aws configure set --profile demo aws_access_key_id <ACCESS_KEY>
aws configure set --profile demo aws_secret_access_key <SECRET_KEY>
aws configure set --profile demo region eu-west-1
```

### Smoke Test

The following provides a simple example fo using the AWS Command Line Interface directly, in this case with the `demo` profile. Remeber S3 bucket names are global and need to be unique, hence using a UUID ensures this. 

```
uuidgen
0e0f6119-96c2-4aa3-819d-166930b95941
```

List, make, copy file and delete bucket examples:

```
aws s3 ls --profile demo
aws s3 mb s3://demo-bucket-0e0f6119-96c2-4aa3-819d-166930b95941 --profile demo
aws s3 cp sample.jpg demo-bucket-0e0f6119-96c2-4aa3-819d-166930b95941 --profile demo
aws s3 rm s3://demo-bucket-0e0f6119-96c2-4aa3-819d-166930b95941 --profile demo
```

## Terraform

Install Terraform using package management:

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
```

```
terraform version
Terraform v1.1.7
on linux_amd64
```

Using `terraform/s3-example` you can see how the AWS identity profile is specified, for example:

```
provider "aws" {
  profile = "demo"
  region  = "${var.region}"
}
```

Therefore, here is how Terraform can be used:

```
cd terraform/s3-example
terraform init
terraform apply
terraform destroy
```


## MkDocs

This project includes some documentation generated using MkDocs and provides a simple, yet practical working example for building and deploying an application.

To work with the Python project locally:

```
cd mkdocs
python3 -m venv venv
. venv/bin/activate
pip install -r requirements.txt
```

Export any require environment variables:

```
export MKDOCS_SITE_NAME='exampleforyou.net'
```

The site can be built using:

```
mkdocs build
```

## kubectl

Download `kubectl`:

```
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl ~/bin
```

## eksctl

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
```