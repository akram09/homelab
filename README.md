# My Home Lab 
This repository includes Infrastructure as A Code configuration to deploy and configure my personal homelab. It leverages Ansible, Terraform, go-tasks ... and several tools that are presentend in the following sections. 

## Hardware
Currently my homelab is limited to a single laptop, that I no longer use: 
    - Dell XPS 9570
        - Intel i7 8750h 
        - 20 GB RAM 
        - 512GB NVME
    - External Hard Drive 4TB 

## General Architecture 
To setup the kubernetes cluster, we will leverage Proxmox as the main hypervisor. On top of it, we provision 3 main virtual machines (k8s cluster) and a virtual machine for TrueNas. 

### Getting started 
First Proxmox needs to be installed on the main machine, It is preferable to install it using the Proxmox VE ISO, Follow this [GUIDE](https://www.proxmox.com/en/proxmox-virtual-environment/get-started).


#### Create a non-root user
Once Installed, Log in to your proxmox instance url https://$ip_address:8086, and open the shell section. 

~~~bash
adduser mgrsys
apt update
apt install -y sudo
usermod -aG sudo mgrsys
echo "mgrsys ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/mgrsys
newgrp sudo
su - mgrsys
sudo apt update
~~~
#### Setup SSH key 
[Post install] Add SSH keys (or use ssh-copy-id on the client that is connecting)

📍 First make sure your ssh keys are up-to-date and added to your github account as [instructed](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

~~~bash
mkdir -m 700 ~/.ssh
sudo apt install -y curl
curl https://github.com/${github_username}.keys > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
~~~
Test ssh connection with  `ssh mgrsys@$ip_address` 


