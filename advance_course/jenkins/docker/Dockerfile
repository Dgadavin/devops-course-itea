FROM jenkins/jenkins:jdk11

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-transport-https lsb-release ca-certificates \
 && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
 && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
 && echo "deb http://ftp.ua.debian.org/debian testing main" >> /etc/apt/sources.list \
 && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && apt-get update && \
 groovy

COPY jenkins-setup.groovy /usr/share/jenkins/ref/init.groovy.d/initial-setup.groovy

RUN /usr/local/bin/install-plugins.sh \
    git-parameter:0.8.0 \
    dynamic_extended_choice_parameter \
    git:3.2.0 \
    github:1.27.0 \
    multiple-scms \
    envinject \
    ssh-agent \
    groovy \
    cloverphp \
    allure-jenkins-plugin \
    simple-theme-plugin:0.4 \
    matrix-project:1.11 \
    matrix-auth:2.2 \
    job-dsl:1.66 \
    workflow-aggregator

EXPOSE 8080
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

# docker run -p 8080:8080 -e ENV=qa -e AWS_DEFAULT_REGION=eu-west-1 <image-name>
