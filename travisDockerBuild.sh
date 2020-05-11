#!/bin/sh
docker login $REGISTRY_URL -u $USERNAME -p $PASSWORD
docker build -t $REGISTRY_URL/lakhiyani/shell-in-container .
docker push $REGISTRY_URL/lakhiyani/shell-in-container
