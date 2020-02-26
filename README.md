# Exercise

## Run the app locally
### Steps to run Flask App using virtualenv:

```bash
export FLASK_ENV='development' \
virtualenv -p python3 myenv \
source myenv/bin/activate \
pip install -r requirements.txt \
python3 main.py
```

### Steps to run Flask App using docker:
Docker must be installed in your system. In this example, we will bind the port 8080 on the container with the port 8080 in your machine, but you can change it.
The 'tag' used to build the Docker images is 'my-app', you can change it too.
```bash
docker build -t "my-app" .
docker run -d -p 8080:8080 --name my-first-app my-app
docker ps
```

### Test the Flask App
Once the app is running, you can perform a little test:

 ```bash
#GET
curl localhost:8080/test

#POST
curl -X POST localhost:8080/test
```

## Getting started

### Amazon Web Services (AWS)
For this exercise, the cloud platform used will be AWS. We will use the following services:
* EC2 (Amazon Elastic Compute Cloud) to launch an Instance (a virtual server) where the application will be running.
* ECR (Elastic Container Registry) to store, manage and deploy the Docker container image
* IAM (AWS Identity and Access Management) to create a new role, which will be attached to the instance.

There are many ways to use and interact with all AWS services. Some of them are:
* Amazon Management Console (using your favorite web browser)
* Amazon Command Line Interface (aws cli)
* AWS CloudFormation
* AWS SDK (AWS Software Development Kit)
* Ansible modules
* Terraform

### Step 1: Create a new IAM role
This role will be used by our EC2 instance. You can find more details below:
1. Type of trusted entity: AWS Services
2. Use case: EC2
3. Permission policies: AmazonEC2ContainerRegistryFullAccess \

https://docs.aws.amazon.com/AmazonECR/latest/userguide/security_iam_id-based-policy-examples.html

### Step 2: Launch an EC2 Instance
The easiest way to launch an instance is using Amazon Management Console, but it is your choice. When you are creating the instance, you have to perform two relevant actions:
1. Attach the IAM Role created in the Step 1 to the new instance
2. Add [the following script](user_data.sh) in the User Data field.  This script is used to complete two tasks, the first is add a new user who will contain your SSH public key, and you will use to run the Ansible playbooks (yes, the EC2 Instance will be provisioned using Ansible). The second task is install AWS CLI, used to login into the private registry and create a new repository

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html

### Step 3: Create an ECR repository and push the container image
Install the following packages if them are not already installed in your system:
* aws-cli
* jq
```bash
snap install aws-cli --classic
snap install jq
```
Add your access keys and preferences to use aws-cli. You can use the following command:
```bash
aws configure
```
After run the last command, your credentials and configurations should be in ~/.aws/credentials and ~/.aws/config.
Use [the following script](create_ecr_registry_and_push_image.sh). This script receive one argument, the repository's name, If you forget this argument, the script will fails.



### Step 4: Complete and replace the variables
You have to replace the variables in the following files:
* inventory/my_inventory : Complete the list with the IP of your instances (virtual servers)
* roles/run-container/vars/main.yml : Complete with the your private registry's name, region and image's name.
* ansible.cfg file: Here you have to specify the remote user, the ssh key, and you can change the inventory location if you want to use your own custom inventory.

### Step 5: Run the playbook
You have to be on the ansible directory to run the following command.
```bash
ansible-playbook main.yml
```
