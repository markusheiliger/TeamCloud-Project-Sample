#!/bin/bash

trace() {
    echo -e "\n>>> $@ ...\n"
}

trace "Kubernetes config" 
kubectl config view

trace "Secrets"
tree /mnt/secrets