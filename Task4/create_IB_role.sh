#!/bin/bash
set -e

mkdir -p certs

openssl genrsa -out certs/user_ib.key 2048
openssl req -new -key certs/user_ib.key -out certs/user_ib.csr -subj "/CN=ib/O=cluster-secret"
openssl x509 -req -in certs/user_ib.csr -CA  /cygdrive/c/Users/itsid/.minikube/ca.crt -CAkey /cygdrive/c/Users/itsid/.minikube/ca.key -CAcreateserial -out certs/user_ib.crt -days 365

echo "Пользователь user_ib создан"

kubectl create clusterrole cluster-secret --verb=get,list,watch,create,update,patch,delete --resource=secrets

echo "Кластерная роль cluster-secret создана"

kubectl create clusterrolebinding user_ib-cluster-secret-binding --clusterrole=cluster-secret --user=user_ib

echo "Пользователь user_ib связан с ролью cluster-secret"