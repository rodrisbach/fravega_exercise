# Exercise

## Run the app locally
### Steps to run Flask App using virtualenv:

```bash
export FLASK_ENV='development'
virtualenv -p python3 myenv
source myenv/bin/activate
pip install -r requirements.txt
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
2. Add the following User Data to create an user whit your public SSH key and install aws cli.
```bash
#!/bin/bash
NEWUSER="<YOUR_USER>"
NEWUSERKEY="<YOUR_SSH_PUBLIC_KEY>"
adduser $NEWUSER
echo "$NEWUSER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
mkdir -p /home/$NEWUSER/.ssh
echo $NEWUSERKEY >> /home/$NEWUSER/.ssh/authorized_keys
chown -R $NEWUSER:$NEWUSER /home/$NEWUSER/.ssh
chmod 0700 /home/$NEWUSER/.ssh
chmod 0600 /home/$NEWUSER/.ssh/authorized_keys
snap install aws-cli --classic
```
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html
