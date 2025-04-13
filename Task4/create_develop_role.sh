#!/bin/bash
set -e

mkdir -p certs

openssl genrsa -out certs/user_develop.key 2048
openssl req -new -key certs/user_develop.key -out certs/user_develop.csr -subj "/CN=ib/O=role-user_develop"
openssl x509 -req -in certs/user_develop.csr -CA  /cygdrive/c/Users/itsid/.minikube/ca.crt -CAkey /cygdrive/c/Users/itsid/.minikube/ca.key -CAcreateserial -out certs/user_develop.crt -days 365

echo "Пользователь user_develop создан"

kubectl create role role-develop --verb=get,list,watch --resource=pods,services,deployments,configmaps

echo "Роль role-develop создана"

kubectl create rolebinding user_develop-role-develop-binding --clusterrole=role-develop --user=user_develop

echo "Пользователь user_develop связан с ролью role-develop"