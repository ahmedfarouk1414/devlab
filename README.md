##  prepaer and install dokcer  
  sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'  
   [docker-ce-edge]
   name=Docker CE Edge - $basearch
    baseurl=https://download.docker.com/linux/centos/7/$basearch/edge
    enabled=1
    gpgcheck=1
    gpgkey=https://download.docker.com/linux/centos/gpg
    EOF 
    
  - yum install -y docker-ce-18.06.1.ce-3.el7.x86_64  conntrack && sudo systemctl start docker && sudo systemctl status docker && sudo systemctl enable docker

##  prepaer and install minikube  
  - kube_version=v1.12.2
  - curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/${kube_version}/bin/linux/amd64/kubect
  - mv kubectl /usr/local/sbin/
  - curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  - mv minikube-linux-amd64 minikube && chmod +x minikube && mv minikube /usr/local/sbin/
  - minikube start --vm-driver=none
  - kubectl get node
 
##  install auto completion   
  - source <(kubectl completion bash) 
  - echo "source <(kubectl completion bash)" >> ~/.bashrc

## install helm 
 - kubectl apply -f https://raw.githubusercontent.com/ahmedfarouk1414/playjenkins/master/helm.sh ### from my own repo 
   
## add slave container as pod that containe custem dependence for java 


## install jenkins from helm 
   - kubectl inspect stable/jenkins > /tmp/jenkins-values
   - helm install --name jenkins stable/jenkins --namespace build  --values jenkins-values     ### from my repo 
   
## create pipline for deployment 

## create nexus 
    - kubectl apply -f https://raw.githubusercontent.com/ahmedfarouk1414/playjenkins/master/nexus.yaml    ### from myrepo##

## create databases
  - docker pull mysql/mysql-server:latest
  - docker run --name=mysql -d mysql/mysql-server:latest
  - docker logs 64d781449723 | grep -i pass
        [Entrypoint] GENERATED ROOT PASSWORD: K@N@Soq)oMerJ0SIkMized4BEj@r
  - docker exec -it [container_name] mysql -uroot -p
       K@N@Soq)oMerJ0SIkMized4BEj@r
       
    mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'ahmed';
         > create databases toystore
         
  - cat toystore-test.sql  | docker exec -i mysql /usr/bin/mysql -u root --password=ahmed mysql
  - docker commit mysql mysqldump
  - docker tag mysql  ahmedfarouk141414/toystore:v1
  - docker push  ahmedfarouk141414/toystore:v1

