#Define Veriable for Custom Claster Name
my_cluster = kind
list_cluster := $(shell kind get clusters)
#For make your environment ready for kind and kubernetes
new:
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64 && chmod +x ./kind && mv ./kind /usr/local/bin/kind

kubectl:
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
        curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
        install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#After making ready environment just following are up a cluster
docker: 
        apt-get install ca-certificates curl gnupg
        install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        chmod a+r /etc/apt/keyrings/docker.gpg
        echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable"
        tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
up:
        kind create cluster --name $(my_cluster)
#The followings are remove you cluster
delete:
        kind delete cluster --name $(list_cluster)
#For checking if you cluster is ready
check:
        echo $(list_cluster)
