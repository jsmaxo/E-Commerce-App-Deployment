aws eks --region eu-west-1 update-kubeconfig --name ecom-eks-cluster

aws s3 mb s3://terraform-s3-backend-901970227725 --region eu-west-1

eksctl create iamserviceaccount \
    --cluster=ecom-eks-cluster \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --attach-policy-arn=arn:aws:iam::023703348895:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --region eu-west-1 \
    --approve

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=ecom-eks-cluster \
  --set serviceAccount.create=false \
  --set region=eu-west-1 \
  --set vpcId=vpc-0702ddc08d758c0f5 \
  --set serviceAccount.name=aws-load-balancer-controller \
  --version 1.14.0

  eksctl create iamserviceaccount \
        --name ebs-csi-controller-sa \
        --namespace kube-system \
        --cluster ecom-eks-cluster \
        --role-name AmazonEKS_EBS_CSI_DriverRole \
        --role-only \
        --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicyV2 \
        --approve
......................................................................

eksctl delete iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster ecom-eks-cluster \
  --region eu-west-1

  eksctl create iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster ecom-eks-cluster \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --region eu-west-1

  kubectl rollout restart deployment ebs-csi-controller -n kube-system

   kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-drive

   aws iam get-role --role-name AmazonEKS_EBS_CSI_DriverRole

   