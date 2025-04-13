#!/bin/bash
set -e

mkdir -p certs

openssl genrsa -out certs/user_devops.key 2048
openssl req -new -key certs/user_devops.key -out certs/user_devops.csr -subj "/CN=ib/O=role-devops"
openssl x509 -req -in certs/user_devops.csr -CA  /cygdrive/c/Users/itsid/.minikube/ca.crt -CAkey /cygdrive/c/Users/itsid/.minikube/ca.key -CAcreateserial -out certs/user_devops.crt -days 365

echo "Пользователь user_devops создан"

kubectl create role role-devops --verb=get,list,watch,create,update,patch,delete --resource=pods,services,deployments,configmaps

echo "Роль role-devops создана"

kubectl create rolebinding user_devops-role-devops-binding --clusterrole=role-devops --user=user_devops

echo "Пользователь user_devops связан с ролью role-devops"