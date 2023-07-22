my_cluster = kind
list_cluster := $(shell kind get clusters)

new:
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64 && chmod +x ./kind && mv ./kind /usr/local/bin/kind

kubectl:
        curl -LO "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        curl -LO "https://dl.k8s.io/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
        echo "$$(cat kubectl.sha256)  kubectl" | sha256sum --check
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

docker:
        apt update -y
        sudo apt install apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
        sudo apt install -y docker-ce

up:
        kind create cluster --name $(my_cluster)

delete:
        kind delete cluster --name $(list_cluster)

check:
        echo $(list_cluster)

deploy:
        kubectl apply -f deployment.yaml
