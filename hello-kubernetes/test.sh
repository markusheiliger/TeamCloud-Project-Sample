#!/bin/bash

trace() {
    echo -e "\n>>> $@ ...\n"
}

trace "Kubernetes config" 
kubectl config view
