# Getting Started

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