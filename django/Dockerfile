FROM python:3.6

RUN apt-get update && \
    apt-get install -y && \
    apt install libgirepository1.0-dev -y && \
    pip3 install uwsgi && \
    pip3 install psycopg2 

COPY ./mysite /opt/app
RUN chmod 777 /opt/app/mysite
WORKDIR /opt/app

RUN pip3 install -r /opt/app/requirements.txt

ENV DJANGO_ENV=prod
ENV DOCKER_CONTAINER=1

EXPOSE 8000

CMD ["uwsgi", "--wsgi-file", "/opt/app/mysite/wsgi.py", \
              "--enable-threads", \
              "--http", "0.0.0.0:8000"]
