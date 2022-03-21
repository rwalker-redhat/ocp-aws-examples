# Elastic Kubernetes Service

When coming at this for the first time it quickly became apparent that using command line tools was a more logical approach since the `eksctl` command generates a `~/.kube/config` and you're good to go. 

## Create cluster using CLI

NOTE: The following command created two `m5.large` EC2 instances.

```
eksctl create cluster --name demo-cluster --region eu-west-1 --profile demo
```

Sample output:

```
2022-03-21 12:48:50 [ℹ]  eksctl version 0.88.0
2022-03-21 12:48:50 [ℹ]  using region eu-west-1
2022-03-21 12:48:51 [ℹ]  setting availability zones to [eu-west-1c eu-west-1b eu-west-1a]
2022-03-21 12:48:51 [ℹ]  subnets for eu-west-1c - public:192.168.0.0/19 private:192.168.96.0/19
2022-03-21 12:48:51 [ℹ]  subnets for eu-west-1b - public:192.168.32.0/19 private:192.168.128.0/19
2022-03-21 12:48:51 [ℹ]  subnets for eu-west-1a - public:192.168.64.0/19 private:192.168.160.0/19
2022-03-21 12:48:51 [ℹ]  nodegroup "ng-fb59f3d0" will use "" [AmazonLinux2/1.21]
2022-03-21 12:48:51 [ℹ]  using Kubernetes version 1.21
2022-03-21 12:48:51 [ℹ]  creating EKS cluster "demo-cluster" in "eu-west-1" region with managed nodes
2022-03-21 12:48:51 [ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial managed nodegroup
2022-03-21 12:48:51 [ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=eu-west-1 --cluster=demo-cluster'
2022-03-21 12:48:51 [ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "demo-cluster" in "eu-west-1"
2022-03-21 12:48:51 [ℹ]  CloudWatch logging will not be enabled for cluster "demo-cluster" in "eu-west-1"
2022-03-21 12:48:51 [ℹ]  you can enable it with 'eksctl utils update-cluster-logging --enable-types={SPECIFY-YOUR-LOG-TYPES-HERE (e.g. all)} --region=eu-west-1 --cluster=demo-cluster'
2022-03-21 12:48:51 [ℹ]  
2 sequential tasks: { create cluster control plane "demo-cluster", 
    2 sequential sub-tasks: { 
        wait for control plane to become ready,
        create managed nodegroup "ng-fb59f3d0",
    } 
}
2022-03-21 12:48:51 [ℹ]  building cluster stack "eksctl-demo-cluster-cluster"
2022-03-21 12:48:51 [ℹ]  deploying stack "eksctl-demo-cluster-cluster"
2022-03-21 12:59:54 [ℹ]  waiting for CloudFormation stack "eksctl-demo-cluster-cluster"
2022-03-21 13:01:56 [ℹ]  building managed nodegroup stack "eksctl-demo-cluster-nodegroup-ng-fb59f3d0"
2022-03-21 13:01:56 [ℹ]  deploying stack "eksctl-demo-cluster-nodegroup-ng-fb59f3d0"
2022-03-21 13:01:56 [ℹ]  waiting for CloudFormation stack "eksctl-demo-cluster-nodegroup-ng-fb59f3d0"
2022-03-21 13:05:18 [ℹ]  waiting for the control plane availability...
2022-03-21 13:05:18 [✔]  saved kubeconfig as "/home/richard/.kube/config"
2022-03-21 13:05:18 [ℹ]  no tasks
2022-03-21 13:05:18 [✔]  all EKS cluster resources for "demo-cluster" have been created
2022-03-21 13:05:18 [ℹ]  nodegroup "ng-fb59f3d0" has 2 node(s)
2022-03-21 13:05:18 [ℹ]  node "ip-192-168-9-208.eu-west-1.compute.internal" is ready
2022-03-21 13:05:18 [ℹ]  node "ip-192-168-94-124.eu-west-1.compute.internal" is ready
2022-03-21 13:05:18 [ℹ]  waiting for at least 2 node(s) to become ready in "ng-fb59f3d0"
2022-03-21 13:05:18 [ℹ]  nodegroup "ng-fb59f3d0" has 2 node(s)
2022-03-21 13:05:18 [ℹ]  node "ip-192-168-9-208.eu-west-1.compute.internal" is ready
2022-03-21 13:05:18 [ℹ]  node "ip-192-168-94-124.eu-west-1.compute.internal" is ready
2022-03-21 13:05:22 [ℹ]  kubectl command should work with "/home/richard/.kube/config", try 'kubectl get nodes'
2022-03-21 13:05:22 [✔]  EKS cluster "demo-cluster" in "eu-west-1" region is ready
```

View cluster nodes:

```
kubectl get nodes -o wide
```

View workload running on the cluster:

```
kubectl get pods --all-namespaces -o wide
```

Delete cluster:

```
eksctl delete cluster --name demo-cluster --region eu-west-1 --profile demo
```
