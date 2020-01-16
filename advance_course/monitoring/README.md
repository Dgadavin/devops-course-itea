# Prometheus practice

## Pre-setup

Create EC2 instance with your SSH key. Login into it and do:

```bash
yum install git docker vim
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
```

In security group please open all traffic for current IP

After please clone our `devops-course-itea` repo

```bash
git clone https://github.com/Dgadavin/devops-course-itea.git
cd devops-course-itea/advance_course/monitoring/prometheus
docker-compose up
```
