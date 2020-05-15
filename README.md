# docker_django_uwsgi
docker network create dognet
cd ~/<this_repo>/postgres
docker image build -t dogdemo/postgres:latest .
docker run -d --name db --network=dognet -p 5432:5432 --log-opt max-size=5m dogdemo/postgres:latest

cd ~/<this_repo>/django
docker image build -t dogdemo/django:latest .
docker run -d --name django --network=dognet -p 8000:8000 --log-opt max-size=5m dogdemo/django:latest

docker run -d --name datadog-agent --log-opt max-size=5m \
--network=dognet \
--restart=unless-stopped \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
-v /proc/:/host/proc/:ro \
-v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
-v /opt/datadog-agent/run:/opt/datadog-agent/run:rw \
-e DD_API_KEY=<YOUR_API_KEY>\
-e DD_LOGS_ENABLED=true \
-e DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true \
-e DD_DOGSTATSD_ORIGIN_DETECTION=true \
-e DD_DOGSTATSD_NON_LOCAL_TRAFFIC=true \
-e DD_TAGS="env:sandbox" \
-e DD_APM_ENABLED=true \
-e DD_APM_NON_LOCAL_TRAFFIC=true \
-e DD_APM_ENV='sandbox' \
-e SD_BACKEND=docker \
datadog/agent:latest
