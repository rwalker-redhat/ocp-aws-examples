# Terraform

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