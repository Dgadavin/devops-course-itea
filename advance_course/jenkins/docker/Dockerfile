FROM jenkins/jenkins:jdk11

USER root

ENV DEBIAN_FRONTEND=noninteractive

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
