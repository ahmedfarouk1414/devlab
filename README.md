 prepaer and install minikube 

  - sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'  
    [docker-ce-edge]
    name=Docker CE Edge - $basearch
    baseurl=https://download.docker.com/linux/centos/7/$basearch/edge
    enabled=1
    gpgcheck=1
    gpgkey=https://download.docker.com/linux/centos/gpg
    EOF 
    
  - yum install -y docker-ce-18.06.1.ce-3.el7.x86_64  conntrack && sudo systemctl start docker && sudo systemctl status docker && sudo systemctl enable docker
