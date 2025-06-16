$ErrorActionPreference = "Stop"

$region = "eu-north-1"
$repoName = "myfirsttestdocket"
$accountId = "358521120998"
$ecrUrl = "$accountId.dkr.ecr.$region.amazonaws.com/$repoName"



# Authenticate Docker to ECR
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $ecrUrl

# Build and push Docker image
docker build -t $repoName .
docker tag "$repoName:latest" "$ecrUrl:latest"
docker push "$ecrUrl:latest"

# Replace placeholder in deployment.yaml
(Get-Content deployment.yaml) -replace '358521120998.dkr.ecr.eu-north-1.amazonaws.com/myfirsttestdocket', "$ecrUrl:latest" | Set-Content deployment.generated.yaml

Write-Host "✅ Image pushed to ECR and deployment.generated.yaml is ready."
