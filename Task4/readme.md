### Таблица ролей

| Роль  | Права роли | Группы пользователей |
| --- | --- | --- |
| cluster-secret | Просмотр и редактирование секретов. Кластерная роль | Специалист ИБ |
| role-devops | Просмотр и редактирование ресурсов кластера. Роль на конкретный неймспейс | DevOps-инженер |
| role-develop | Просмотр ресурсов кластера. Роль на конкретный неймспейс | Разработчик |
| role-develop | Просмотр и редактирование ресурсов кластера. Роль на конкретный неймспейс | Сервисная УЗ |


### Листинг команд

``` sh
itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task4
$ ./create_IB_role.sh
Generating RSA private key, 2048 bit long modulus (2 primes)
.................................................................................................+++++
........................+++++
e is 65537 (0x010001)
Signature ok
subject=CN = ib, O = cluster-secret
Getting CA Private Key
Пользователь user_ib создан
clusterrole.rbac.authorization.k8s.io/cluster-secret created
Кластерная роль cluster-secret создана
clusterrolebinding.rbac.authorization.k8s.io/user_ib-cluster-secret-binding created
Пользователь user_ib связан с ролью cluster-secret

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task4
$ kubectl get clusterroles cluster-secret -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: "2025-04-13T14:12:59Z"
  name: cluster-secret
  resourceVersion: "35585"
  uid: d5655882-48f1-4856-91a4-3049374889e1
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task4
$ ./create_devops_role.sh
Generating RSA private key, 2048 bit long modulus (2 primes)
...+++++
.......................+++++
e is 65537 (0x010001)
Signature ok
subject=CN = ib, O = role-devops
Getting CA Private Key
Пользователь user_devops создан
role.rbac.authorization.k8s.io/role-devops created
Роль role-devops создана
rolebinding.rbac.authorization.k8s.io/user_devops-role-devops-binding created
Пользователь user_devops связан с ролью role-devops

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task4
$ kubectl get roles role-devops  -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2025-04-13T17:40:04Z"
  name: role-devops
  namespace: default
  resourceVersion: "42953"
  uid: 3c879a01-e639-4484-b9bc-65572f0f1f41
rules:
- apiGroups:
  - ""
  resources:
  - pods
  - services
  - configmaps
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
- apiGroups:
  - apps
  resources:
  - deployments
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task4
$ ./create_develop_role.sh
Generating RSA private key, 2048 bit long modulus (2 primes)
......+++++
........................................................+++++
e is 65537 (0x010001)
Signature ok
subject=CN = ib, O = role-user_develop
Getting CA Private Key
Пользователь user_develop создан
role.rbac.authorization.k8s.io/role-develop created
Роль role-develop создана
rolebinding.rbac.authorization.k8s.io/user_develop-role-develop-binding created
Пользователь user_develop связан с ролью role-develop

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task4
$ kubectl get roles role-develop  -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2025-04-13T17:52:04Z"
  name: role-develop
  namespace: default
  resourceVersion: "43523"
  uid: a65236af-95ec-4f44-be46-8a238de13ef0
rules:
- apiGroups:
  - ""
  resources:
  - pods
  - services
  - configmaps
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - apps
  resources:
  - deployments
  verbs:
  - get
  - list
  - watch

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task4
$ ./create_srv_acc.sh
serviceaccount/srv created
Сервисный аккаунт srv создан
eyJhbGciOiJSUzI1NiIsImtpZCI6Im9tU21TZXhNZ21kRG4xa2NTSXVubjNIVEhaLTVkLXo0X1dRM3dKWU04ZTAifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXI
...
Токен доступа для аккаунта srv создан
rolebinding.rbac.authorization.k8s.io/srv-role-devops-binding created
Пользователь srv связан с ролью role-devops

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task4
$ kubectl get serviceaccount srv -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2025-04-13T18:02:45Z"
  name: srv
  namespace: default
  resourceVersion: "44017"
  uid: 6947d6f2-0d28-4b22-8243-e0031c677dc3

```