#!/usr/bin/env bash
echo "install helm"
# installs helm with bash
wget https://get.helm.sh/helm-v2.14.2-linux-amd64.tar.gz
tar -xvf helm-v2.14.2-linux-amd64.tar.gz
cd linux-amd64
mv helm  /usr/local/sbin/

# add a service account within a namespace to segregate tiller
kubectl create serviceaccount -n kube-system tiller

# create a cluster role binding for tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller

# initialized helm within the tiller service account
helm init --service-account tiller --override spec.selector.matchLabels.'name'='tiller',spec.selector.matchLabels.'app'='helm' --output yaml | sed 's@apiVersion: extensions/v1beta1@apiVersion: apps/v1@' | kubectl apply -f -
