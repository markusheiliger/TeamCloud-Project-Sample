#!/bin/bash

trace() {
    echo -e "\n>>> $@ ...\n"
}

trace "Credentials"
tree /mnt/credentials

trace "Password"
/mnt/credentials/password

trace "Kubernetes config" 
kubectl config view

