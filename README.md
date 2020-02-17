# Exercise

## Steps to execute the main.py file locally:

´´´bash
export FLASK_ENV='development'
virtualenv -p python3 myenv
source myenv/bin/activate
pip install -r requirements.txt
python3 main.py
´´´

Now, you can test it using *curl*
´´´bash
#GET
curl localhost:8080/test

#POST
curl -X POST localhost:8080/test
´´´
