#!/usr/bin/env bash

set -e

IFS=$'\n\t'

_verify_ansible() {
if [ -x "$(command -v ansible-galaxy)" ]; then
  # install role
  ansible-galaxy install git+https://github.com/elastic/ansible-elastic-cloud-enterprise.git
else
  echo "ERROR: Ansible isn't installed on this machine, aborting ece installation"
  echo "Installing Ansible..."
  sudo apt update
  sudo apt install software-properties-common -y
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install ansible -y && ansible-galaxy install git+https://github.com/elastic/ansible-elastic-cloud-enterprise.git
fi
}

_write_ansible_playbook() {
cat << PLAYBOOK > ./ece.yml
---
- hosts: primary
  gather_facts: true
  roles:
    - ansible-elastic-cloud-enterprise
  vars:
    ece_primary: true
    ece_version: ${ece-version}

- hosts: secondary
  gather_facts: true
  roles:
    - ansible-elastic-cloud-enterprise
  vars:
    ece_roles: [director, coordinator, proxy, allocator]
    ece_version: ${ece-version}

- hosts: tertiary
  gather_facts: true
  roles:
    - ansible-elastic-cloud-enterprise
  vars:
    ece_roles: [director, coordinator, proxy, allocator]
    ece_version: ${ece-version}
PLAYBOOK
}

_write_ansible_hosts() {
cat << HOSTS_FILE > ./hosts
[primary]
${ece-server0}

[primary:vars]
availability_zone=${ece-server0-zone}

[secondary]
${ece-server1}

[secondary:vars]
availability_zone=${ece-server1-zone}

[tertiary]
${ece-server2}

[tertiary:vars]
availability_zone=${ece-server2-zone}

[aws:children]
primary
secondary
tertiary

[aws:vars]
ansible_ssh_private_key_file=${key}
ansible_user=${user}
ansible_become=yes
device_name=${device}
HOSTS_FILE
}

_run_ansible() {
  export ANSIBLE_HOST_KEY_CHECKING=False
  ansible-playbook -i hosts ece.yml
}

_verify_ansible
_write_ansible_playbook
_write_ansible_hosts
sleep ${sleep-timeout}
_run_ansible