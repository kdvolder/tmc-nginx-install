#!/bin/bash

# Install nginx ingress contoller
#kapp deploy -a nginx -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.45.0/deploy/static/provider/cloud/deploy.yaml

# After this step you have to find out the address of your load balancer
kubectl get -n ingress-nginx services ingress-nginx-controller
# At this point you have to configure dns records to point to your ELB. This is a manual step that requires AWS account, or 
# another account with a domain provider. Ask your sysadmin person about AWS DNS. Or get your own DNS somehow.

# Install cert-manager
kapp deploy -a cert-manager -f https://github.com/jetstack/cert-manager/releases/download/v1.3.0/cert-manager.yaml

# Setup 'lets-encrypt' certificate issuers
# You need to edit the file deployed below to add your own email address
kapp deploy -a lets-encrypt -f lets-encrypt.yml

#Deploy hello-world sample app
### Note: the certificates in the example will be issued for specific DNS names. So you will have to edit them for your own DNS names.
kapp deploy -a hello -f hello-world-sample.yml