FROM python:3.7-alpine

RUN mkdir /app

WORKDIR /app

COPY code/* ./

RUN pip install -r requirements.txt

ENV FLASK_ENV=development

CMD ["python","-u","main.py"]
