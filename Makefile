#Define Veriable for Custom Claster Name
my_cluster = kind
list_cluster := $(shell kind get clusters)
#For make your environment ready for kind 
new:
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64 && chmod +x ./kind && mv ./kind /usr/local/bin/kind
#After making ready environment just following are up a cluster
up:
        kind create cluster --name $(my_cluster)
#The followings are remove you cluster
delete:
        kind delete cluster --name $(list_cluster)
#For checking if you cluster is ready
check:
        echo $(list_cluster)
