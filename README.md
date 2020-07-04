##  prepaer and install dokcer  
 	 sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'  
   		[docker-ce-edge]
   		name=Docker CE Edge - $basearch
	    	baseurl=https://download.docker.com/linux/centos/7/$basearch/edge
   		 enabled=1
   		 gpgcheck=1
   		 gpgkey=https://download.docker.com/linux/centos/gpg
   		 EOF 
    
    - yum install -y docker-ce-18.06.1.ce-3.el7.x86_64  conntrack 
    - sudo systemctl start docker && sudo systemctl status docker && sudo systemctl enable docker

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
 - kubectl apply -f manifest/helm.sh 
   
## install jenkins from helm 
   - kubectl inspect stable/jenkins > /tmp/jenkins-values
   - helm install --name jenkins stable/jenkins --namespace build  --values manifest/jenkins-values
   - add credentials for (kubeconfig && nexus)

## create nexus 
    - kubectl apply -f manifest/nexus.yaml 

    – create a private (hosted) repository for our own images
    - create user and give permission that will allow to push and pull image 
    - edit all host worker node configration /etc/docker/daemon.json

  		{
 		 "insecure-registries": [
   		       "your-IP:32323",
  			],
  	"disable-legacy-registry": true
	}
    - systemctl restart docker)
 
    - docker login -u admin -p admin123 your-IP:32323



## create pipline for deployment 
      - agent slave 
      - staging (Build && Push && Deploy)

## add slave container in separated (pod) that containe custem dependence for java and maven 
that will use to build and push image also
   - image name ahmedfarouk141414/javamavn
   - add jenkins slave credentials kind (ssh username with privte key) from mykey file in github installation/mykey 
   - choose agent slave in pipeline

## create databases and restore backup
  - docker pull mysql/mysql-server:latest
  - docker run --name=mysql -d mysql/mysql-server:latest
  - docker logs 64d781449723 | grep -i pass
        [Entrypoint] GENERATED ROOT PASSWORD: K@N@Soq)oMerJ0SIkMized4BEj@r
  - docker exec -it [container_name] mysql -uroot -p
       K@N@Soq)oMerJ0SIkMized4BEj@r
       
    mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'ahmed';
         > create databases toystore
         
  - cat toystore-test.sql  | docker exec -i mysql /usr/bin/mysql -u root --password=ahmed mysql
  - docker commit mysql 
  - docker tag mysql  ahmedfarouk141414/toystore:v1
  - docker push  ahmedfarouk141414/toystore:v1

## deployment database myapp 
  - cd manifest/db
  - kubectl apply -f . 

## deployment app myapp 
  - use env varible in  application.properties and configfile will replace this values 

   	spring.datasource.url=${spring.datasource.url}
	spring.datasource.username=${spring.datasource.username}
	spring.datasource.password=${spring.datasource.password}
	
  - cd manifest/spring/
  - kubectl apply -f  .




