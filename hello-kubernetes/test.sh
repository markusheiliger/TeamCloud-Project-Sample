#!/bin/bash

trace() {
    echo -e "\n>>> $@ ...\n"
}

trace "Kubernetes config" 
kubectl config view

trace "Credentials"
tree /mnt/credentials

trace "Secrets"
tree /mnt/secrets