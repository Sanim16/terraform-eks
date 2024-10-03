# Deploy AWS EKS using Terraform

>This is a Terraform project that deploys an EKS cluster along with a VPC, KMS(for encryption) and S3 & Dynamodb for backend management.

## Technologies:
- Terraform
- AWS VPC
- AWS KMS
- AWS EKS
- AWS S3
- AWS Dynamodb


## Tasks:

- Get access id, secret id from AWS and ensure user has enough permissions to create infrastructure
- Change directory into the backend directory and run the following commands
```
terraform init
terraform plan
terraform apply
```
- Uncomment the backend block in provider.tf and rerun the above commands again. This changes the backend from local to remote and uses the newly created S3 bucket and Dynamodb table

- Change directory into the vpc directory and run the following commands to deploy the VPC
```
terraform init
terraform plan
terraform apply
```

- Change directory into the kms directory and run the following commands to create the KMS key
```
terraform init
terraform plan
terraform apply
```

- Change directory back to the main directory and run the following commands to deploy the cluster
```
terraform init
terraform plan
terraform apply
```

- Run `aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)` to create an entry for the cluster in your config file
- Connect to the cluster using `kubectl` and test it.
