$clusterName = "my-k8s-cluster"
$region = "eu-north-1"

# Create EKS cluster
eksctl create cluster --name $clusterName --region $region --nodes 2 --node-type t3.micro --managed

# Deploy to EKS
kubectl apply -f deployment.generated.yaml

Start-Sleep -Seconds 20

# Show service info
kubectl get svc myk8sapp-service
