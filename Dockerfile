FROM python:3.7-alpine

RUN mkdir /app

WORKDIR /app

COPY code/requirements.txt ./
COPY code/main.py ./

ENV FLASK_ENV=development

CMD ["python","-u","main.py"]
