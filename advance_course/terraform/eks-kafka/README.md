## Install terraform

Download 0.12 or higher version of terraform package from official site
https://www.terraform.io/downloads.html
Unzip and copy terraform into /usr/local/bin/terraform12
```bash
cp terraform /usr/local/bin
```

## Install AWS kubectl and IAM authenticator

https://docs.aws.amazon.com/en_us/eks/latest/userguide/install-kubectl.html
https://docs.aws.amazon.com/en_us/eks/latest/userguide/install-aws-iam-authenticator.html

## Configure for manual deploy

Before start we need to set ENV variables
```bash
export TF_VAR_env=dev
```
**Please check if in config/\<env\>-state.conf in key you have valid service name.**
**Don't change the bucket or region**

```bash
terraform init
export TF_VAR_vpc_id=$(aws ec2 describe-vpcs --filters "Name=isDefault, Values=true" --query 'Vpcs[*].{id:VpcId}' --output text --region us-east-1)
export TF_VAR_subnet_id=$(aws ec2 describe-subnets --query 'Subnets[0].{id:SubnetId}' --output text --region us-east-1)
terraform12 plan -var-file=environment/${TF_VAR_env}.tfvars
terraform12 apply -var-file=environment/${TF_VAR_env}.tfvars
```

## Install Helm

```bash
brew install helm # on MAC
wget https://get.helm.sh/helm-v3.0.1-linux-amd64.tar.gz
tar -xvf helm-v3.0.1-linux-amd64.tar.gz
cp linux-amd64/helm /usr/local/bin
```

## Install Confluetn Kafka

```bash
helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts/
helm repo update
helm install itea-kafka confluentinc/cp-helm-charts
```

## Produce and consume messages from CLI

```bash
# Login to kafka POD
kubectl exec -it <POD_NAME> bash -c <CONTAINER_NAME>
# Create topic
kafka-topics --zookeeper itea-kafka-cp-zookeeper-headless:2181 \
             --topic itea-kafka-topic1 \
             --create --partitions 1 \
             --replication-factor 1 \
             --if-not-exists
TEXT="hello world !"
# Produce message
echo $TEXT | kafka-console-producer --broker-list itea-kafka-cp-kafka-headless:9092 --topic itea-kafka-topic1
# Consume message
kafka-console-consumer --bootstrap-server itea-kafka-cp-kafka-headless:9092 \
                      --topic itea-kafka-topic1 \
                      --from-beginning \
                      --timeout-ms 2000 \
                      --max-messages 1 | grep "$TEXT"
```

## Modify Helm chart with custom value

We created in `kafka` folder `custom_value.yaml` file to verride some default kafka params.
We will enable Load balancer for Kafka rest service.

```bash
kafka upgrade itea-kafka -f kafka/custom_values.yaml confluentinc/cp-helm-charts
```

curl -XPOST -H "Content-Type: application/vnd.kafka.json.v2+json" -d @kafka/test.json <REST-URL>/topics/<TOPIC-NAME>

## Monitoring with Prometheus

Install prometheus from Helm chart

```bash
helm install prometheus stable/prometheus
helm install grafana stable/grafana

Import [Confluetn Grafana dashboard](https://github.com/confluentinc/cp-helm-charts/blob/master/grafana-dashboard/confluent-open-source-grafana-dashboard.json)
```
