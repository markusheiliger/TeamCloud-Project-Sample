#!/bin/bash

trace() {
    echo -e "\n>>> $@ ...\n"
}

trace "Credentials"
tree /mnt/credentials

trace "Password"
cat /mnt/credentials/password

trace "Kubernetes config" 
kubectl config view

trace "Kubernetes config (raw)"
cat ~/.kube/config
