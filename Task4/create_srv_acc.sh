#!/bin/bash
set -e

kubectl create serviceaccount srv -n default
echo "Сервисный аккаунт srv создан"

kubectl create token srv -n default
echo "Токен доступа для аккаунта srv создан"

kubectl create rolebinding srv-role-devops-binding --clusterrole=role-devops --user=srv
echo "Пользователь srv связан с ролью role-devops"