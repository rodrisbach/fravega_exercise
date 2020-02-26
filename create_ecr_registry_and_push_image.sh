#/bin/bash
NAME = $1
aws ecr create-repository --repository-name $NAME  --region us-east-1
REPOSITORY_URI = $(aws ecr describe-repositories --repository-name $NAME --region us-east-1| jq .repositories[].repositoryUri)
aws ecr get-login --no-include-email --region us-east-1
#Retrieve the login command to use to authenticate your Docker client to your registry.
docker login -u AWS -p <HASH>
#you have to be inside the GitLab repository to execute the following command:
docker build -t $NAME .
docker tag $NAME:latest $REPOSITORY_URI/$NAME:latest
docker push $REPOSITORY_URI/$NAME:latest
