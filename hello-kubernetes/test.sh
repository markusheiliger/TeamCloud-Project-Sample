#!/bin/bash

trace() {
    echo -e "\n>>> $@ ...\n"
}

trace "Helm install"
helm install "$(uuidgen)" . --wait
