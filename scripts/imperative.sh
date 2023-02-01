#!/bin/bash

# Generates a secret with the password "mypassword"
# When using --from-literal, it base64 encodes the string automatically
1. kubectl create secret generic mysecret --from-literal=password=mypassword


# Create a deployment (any image will do)
2. kubectl create deployment mydeployment --image=nginx


# Check that there is no environment variable
# You need to substitute mydeployment-pod with
# the actual pod.
# This command should give an empty response
3. kubectl exec <mydeployment-pod> -it -- env | grep PASSWORD


# Add environment variables imperatively with set env
# First specify which deployment you are seting the env on
# Then from where you are getting the env
# When writing "secret/mysecret" it knows it is a secret
4. kubectl set env deployment/mydeployment --from secret/mysecret

# Now run the same check again
# Be aware that the pod-name probably has changed
5. kubectl exec <mydeployment-pod> -it -- env | grep PASSWORD

# We can check how it is mounted by doing
6. kubectl get deployment mydeployment -oyaml
 
# In the output you should see something like this:
#  containers:
#      - env:
#        - name: PASSWORD
#          valueFrom:
#            secretKeyRef:
#              key: password
#              name: mysecret

