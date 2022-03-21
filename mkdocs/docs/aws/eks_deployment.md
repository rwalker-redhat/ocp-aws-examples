# Example Deployment

## EKS

```
kubectl create namespace eks-demo-app
```

## Podman Build

```
cd mkdocs
podman build -t demo-mkdocs-img:1.0 .
```

## Run

```
podman run -d -p 8080:80 -e MKDOCS_SITE_NAME="exampleforyou.net" --name demo-mkdocs-ctr localhost/demo-mkdocs-img:1.0
```

## EKS Deployment

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: eks-demo-mkdocs-deployment
  namespace: eks-demo-app
  labels:
    app: eks-demo-mkdocs-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: eks-demo-mkdocs-app
  template:
    metadata:
      labels:
        app: eks-demo-mkdocs-app
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/arch
                operator: In
                values:
                - amd64
      containers:
      - name: nginx
        image: 234497948785.dkr.ecr.eu-west-1.amazonaws.com/demo-mkdocs-img:1.0
        ports:
        - name: http
          containerPort: 8080
        imagePullPolicy: IfNotPresent
      nodeSelector:
        kubernetes.io/os: linux
```

```
kubectl apply -f deployment.yaml
```

```
get pods --namespace eks-demo-app
```

Service:

``` yaml
apiVersion: v1
kind: Service
metadata:
  name: eks-demo-mkdocs-service
  namespace: eks-demo-app
  labels:
    app: eks-demo-mkdocs-app
spec:
  selector:
    app: eks-demo-mkdocs-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

```
kubectl apply -f service.yaml
```


```
kubectl get all -n eks-demo-app
```

```
kubectl -n eks-demo-app describe service eks-demo-mkdocs-service
```


```
kubectl get pods --namespace eks-demo-app
kubectl -n eks-demo-app describe pod eks-demo-mkdocs-deployment-7bf489ffc6-6zgx5
kubectl exec -it eks-demo-mkdocs-deployment-7bf489ffc6-6zgx5 -n eks-demo-app -- /bin/bash
```

```
curl eks-demo-mkdocs-service
```

## Service for external LB

``` yaml
apiVersion: v1
kind: Service
metadata:
  name: eks-demo-mkdocs-service
  namespace: eks-demo-app
  labels:
    app: eks-demo-mkdocs-app
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: external
    service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: ip
    service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
spec:
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
  type: LoadBalancer
  selector:
    app: eks-demo-mkdocs-app
```

```
kubectl get svc eks-demo-mkdocs-service -n eks-demo-app
```

```
kubectl delete svc eks-demo-mkdocs-service -n eks-demo-app
```