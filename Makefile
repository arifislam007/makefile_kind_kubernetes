#Define Veriable for Custom Claster Name
my_cluster = kind
list_cluster := $(shell kind get clusters)
#For make your environment ready for kind and kubernetes
new:
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64 && chmod +x ./kind && mv ./kind /usr/local/bin/kind
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
        curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
        install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#After making ready environment just following are up a cluster
up:
        kind create cluster --name $(my_cluster)
#The followings are remove you cluster
delete:
        kind delete cluster --name $(list_cluster)
#For checking if you cluster is ready
check:
        echo $(list_cluster)
