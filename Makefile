NAME := hello-node
IMAGE_VERSION := 1.0

.PHONY: all
all: dockerfile deployment

.PHONY: dockerfile
dockerfile:
	eval $(minikube docker-env)
	docker build . --tag $(NAME):$(IMAGE_VERSION)

.PHONY: deployment
deployment:
	kubectl apply -k kustomize

.PHONY: clean
clean:
	kubectl delete deployment $(NAME)