#  prepaer and install minikube 
  sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'  
   [docker-ce-edge]
   name=Docker CE Edge - $basearch
    baseurl=https://download.docker.com/linux/centos/7/$basearch/edge
    enabled=1
    gpgcheck=1
    gpgkey=https://download.docker.com/linux/centos/gpg
    EOF 
    
  - yum install -y docker-ce-18.06.1.ce-3.el7.x86_64  conntrack && sudo systemctl start docker && sudo systemctl status docker && sudo systemctl enable docker

  - kube_version=v1.12.2
  - curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/${kube_version}/bin/linux/amd64/kubect
  - mv kubectl /usr/local/sbin/
  - curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  - mv minikube-linux-amd64 minikube && chmod +x minikube && mv minikube /usr/local/sbin/
  - minikube start --vm-driver=none
  - kubectl get node
  
  - source <(kubectl completion bash) 
  - echo "source <(kubectl completion bash)" >> ~/.bashrc
## adafasfasfasafafa 
  -aaffafa
### aadasdasdasfasfasfafas

** sfsfsfsa** 
  -s sacascas
