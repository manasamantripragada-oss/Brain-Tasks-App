# Clone repo & quick local run (port 3000)
# Dockerize — Dockerfile and .dockerignore
# Create ECR repository and push image
#Create EKS cluster (eksctl) and confirm
Kubernetes manifests (deployment + service)
Deploy:
    kubectl apply -f k8s_deployment.yml
    kubectl apply -f k8s_service.yml
    kubectl svc brain-tasks-service
When External Ip is ready, need to open in the browser
buildspec.yml for AWS CodeBuild (build, docker build & push to ECR)
CodeBuild Project creation
CodeDeploy application (optional) and appspec.yml
Using CodePipeline to connect GitHub → CodeBuild → Deploy to EKS
Git (push code to GitHub)
    ECR: CodeBuild needs permissions to ecr:GetAuthorizationToken, ecr:BatchCheckLayerAvailability, ecr:PutImage, ecr:InitiateLayerUpload, ecr:UploadLayerPart, ecr:CompleteLayerUpload.

    CodeBuild: needs CloudWatchLogs, S3 (if using artifacts), ECR push, and optional EKS access if deploying (eks:DescribeCluster, eks:ListClusters).

    CodePipeline: needs to assume CodeBuild roles and access to GitHub (via token).

    EKS: grant IAM user permission to create kubeconfig and kubectl access; create aws-auth ConfigMap for node IAM roles if needed.
Monitoring with CloudWatch Logs
Verification & troubleshooting checklist
    aws ecr describe-repositories --repository-names brain-tasks-app --region US-EAST-1
    aws ecr list-images --repository-name brain-tasks-app --region us-east-1
    kubectl get nodes
    kubectl get deployments
    kubectl get svc
    kubectl get pods -l app=brain-tasks
    kubectl logs $(kubectl get pods -l app=brain-tasks -o jsonpath='{.items[0].metadata.name}')
    aws codebuild batch-get-builds --ids <build-id>
    aws logs describe-log-groups
    aws logs tail /aws/codebuild/brain-tasks-codebuild --since 1h

    




