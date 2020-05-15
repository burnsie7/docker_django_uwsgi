#/bin/bash
docker container stop $1
sleep 5
docker container rm $1
cd /home/ubuntu/venmo/django
docker image build -t dogdemo/django:latest .
docker run -it --name django --network=dognet -p 8000:8000 --log-opt max-size=5m dogdemo/django:latest
