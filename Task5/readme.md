### Листинг команд

``` sh
itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task5
$ kubectl create namespace develop
namespace/develop created

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task5
$ kubectl apply -f network-policy-deny-all.yaml -n develop
networkpolicy.networking.k8s.io/default-deny-all created

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task5
$ kubectl apply -f network-policy-app.yaml -n develop
networkpolicy.networking.k8s.io/allow-frontend-to-backend created

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task5
$ kubectl apply -f deployment-admin.yaml -n develop
deployment.apps/admin-front-end-deploy created
service/admin-front-end-srv created
deployment.apps/admin-back-end-api-deploy created
service/admin-back-end-api-srv created

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task5
$ kubectl apply -f network-policy-admin.yaml -n develop
networkpolicy.networking.k8s.io/allow-admin-frontend-to-backend created

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task5
$ kubectl get pod,svc -o wide -n develop
NAME                                             READY   STATUS    RESTARTS        AGE   IP            NODE       NOMINATED NODE   READINESS GATES
pod/admin-back-end-api-deploy-77d44d499b-q5w25   1/1     Running   1 (6m47s ago)   74m   10.244.0.70   minikube   <none>           <none>
pod/admin-front-end-deploy-5f58bf68bc-5zgsp      1/1     Running   1 (6m47s ago)   14m   10.244.0.61   minikube   <none>           <none>
pod/back-end-api-deploy-6f857f5757-wl6ct         1/1     Running   1 (6m47s ago)   18m   10.244.0.71   minikube   <none>           <none>
pod/front-end-deploy-c87dddd99-5mrbr             1/1     Running   1 (6m47s ago)   81m   10.244.0.64   minikube   <none>           <none>

NAME                             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE   SELECTOR
service/admin-back-end-api-srv   ClusterIP   10.98.107.38     <none>        83/TCP    74m   app=admin-back-end-api
service/admin-front-end-srv      ClusterIP   10.109.51.155    <none>        82/TCP    74m   app=admin-front-end
service/back-end-api-srv         ClusterIP   10.102.101.160   <none>        81/TCP    81m   app=back-end-api
service/front-end-srv            ClusterIP   10.104.12.119    <none>        80/TCP    81m   app=front-end

itsid@MSI /cygdrive/d/projects/architecture-sprint-7/Task5
$ kubectl get networkpolicy -n develop
NAME                              POD-SELECTOR              AGE
allow-admin-frontend-to-backend   role=admin-back-end-api   15s
allow-frontend-to-backend         role=back-end-api         22s
default-deny-all                  <none>                    75m


```