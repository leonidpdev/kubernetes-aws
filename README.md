## How to

It is assumed that AWS CLI, Terraform and Kubectl utilities are installed.
If not, visit their official documentation for downloads and installation instructions.

1. `terraform init`

2. `terraform apply`, if no errors - say `yes` to the prompt.

3. Wait until everything will be set up. (about 20 minutes)

4. Run `aws eks update-kubeconfig --region us-east-1 --name testtask-cluster` to add the cluster into kubeconfig

5. Run `kubectl get pods` to see whether pod "testpod" is running.
