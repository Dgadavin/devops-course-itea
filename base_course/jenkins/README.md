# Jenkins

## Setup Jenkins
We will use Amazon Linux v1

`docker run -it -p 8090:8080 amazonlinux:1`

```bash
yum update
yum install wget
yum install git # Only in container
yum install syslog # Only in container
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
yum install jenkins
service jenkins start
yum install java-1.8.0
yum remove java-1.7.0-openjdk # Only on EC2 instances
service jenkins start
```

## Create GitHub webhook
You need to proxy real DNS to your localhost. Ngrok the best way to do this
`docker run -e TARGET_HOST=jenkins -e TARGET_PORT=8080 --link inspiring_ritchie:jenkins gtriggiano/ngrok-tunnel`
