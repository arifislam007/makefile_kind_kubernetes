# makefile_kind_kubernetes

## If you don't have Make command in your ubuntu system just run the following command 
apt install make

## Just go with the following command to create Kubernetes cluster in a single node
#For creating environment for kubetnetes cluste 
make new

### For creating your first kubernetes cluster
make up clusterName

### For check if cluster deployed
make check
### For deleting kubernetes cluster 
make delete 
