# Elastic Container Repository

Export your Amazon account ID to an environment variable, for example:

``` text
export AWS_ACCOUNT_ID='0123456789'
export AWS_REGION='eu-west-1'
```

Authenticate with default registry:

``` text
aws ecr get-login-password --region eu-west-1 --profile demo | podman login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
```

Create a new repository:

``` text
aws ecr create-repository --repository-name demo-mkdocs-img --image-scanning-configuration scanOnPush=true --region ${AWS_REGION} --profile demo
```

Tag a local image:

``` text
podman tag localhost/demo-mkdocs-img:1.0 ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/demo-mkdocs-img:1.0
```

Push the image:

``` text
podman push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/demo-mkdocs-img:1.0
```




Pull image

docker pull aws_account_id.dkr.ecr.region.amazonaws.com/hello-world:latest

Delete image

aws ecr batch-delete-image \
      --repository-name hello-world \
      --image-ids imageTag=latest \
      --region region