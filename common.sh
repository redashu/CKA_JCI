#!/bin/bash 

# enable CNI support  driver in linux kernel 
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables


# For installation only disable swap memory 

swapoff  -a

#  configuring repo -- in exam it will be done by examier   

cat  <<EOF  >/etc/yum.repos.d/kube.repo
[kube]
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
gpgcheck=0
EOF

# Install cre  

yum  install docker  -y 
systemctl start docker
systemctl  enable docker  # default docker start at BOot 

# Install kubeadm -- the official installer of Kubernetes cluster in multi node environment 

yum  install kubeadm  -y
# starting agent service 
systemctl  start  kubelet 
systemctl  enable   kubelet 
