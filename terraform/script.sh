#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

sudo apt-get remove needrestart -y
sudo apt-get update && sudo apt-get --yes --force-yes upgrade
sudo apt install snapd -y
sudo snap install microk8s --classic 
sudo usermod -a -G microk8s $USER
sudo mkdir -p $HOME/.kube
sudo chown -R $USER:$USER $HOME/.kube
sudo microk8s.kubectl config view --raw > $HOME/.kube/config
#newgrp microk8s
sudo snap alias microk8s.kubectl kubectl
sudo microk8s enable ingress prometheus dashboard hostpath-storage metrics-server observability
sudo microk8s kubectl patch svc kube-prom-stack-grafana -n observability --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
sudo microk8s kubectl patch svc kubernetes-dashboard -n kube-system --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
sudo microk8s kubectl patch svc kube-prom-stack-grafana -n observability --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30040}]'
sudo microk8s kubectl patch svc kubernetes-dashboard -n kube-system --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30041}]'
sudo microk8s kubectl apply -f /tmp/deploy.yml
