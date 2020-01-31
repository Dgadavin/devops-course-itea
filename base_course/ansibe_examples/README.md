# Ansible

## Setup inventory file

```bash
touch /hosts
Put such content
[local]
localhost
```

##Ad-hoc commands

```bash
ansible local -m ping  -i hosts --connection local
ansible local -m setup  -i hosts --connection local
ansible local -m shell -a 'uname -a' -i hosts --connection local
ansible local -m copy -a 'src=/etc/motd dest=/tmp/' -i hosts --connection local
```

## Setup Jenkins
We will use Amazon Linux v1

`docker run -it -p 8090:8080 amazonlinux:1 bash`

```bash
yum update
yum install git # Only in container
yum install ansible # Only in container
ansible-playbook ansible.yml -i /hosts --connection local
```
## Install Ansible with python
```bash
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install ansible
```
