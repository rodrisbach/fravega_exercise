# Exercise

## Steps to run Flask App using virtualenv:

```bash
export FLASK_ENV='development'
virtualenv -p python3 myenv
source myenv/bin/activate
pip install -r requirements.txt
python3 main.py
```

## Steps to run Flask App using docker:
Docker must be installed in your system. In this example, we will bind the port 8080 on the container with the port 8080 in your machine, but you can change it.
The 'tag' used to build the Docker images is 'my-app', you can change it too.
```bash
docker build -t "my-app" .
docker run -d -p 8080:8080 --name my-first-app my-app
docker ps
```

## Test the Flask App
Once time that the app is running, you can perform a little test:

 ```bash
#GET
curl localhost:8080/test

#POST
curl -X POST localhost:8080/test
```


