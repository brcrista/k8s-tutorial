NAME := hello-node
IMAGE_VERSION := 1.0
PORT := 8080

.PHONY: all
all: dockerfile deployment service

.PHONY: dockerfile
dockerfile:
	eval $(minikube docker-env)
	docker build . --tag $(NAME):$(IMAGE_VERSION)

.PHONY: deployment
deployment:
	kubectl apply -k kustomize

.PHONY: service
service:
	kubectl expose deployment $(NAME) --type=LoadBalancer --port=$(PORT)

.PHONY: clean
clean:
	kubectl delete service $(NAME)
	kubectl delete deployment $(NAME)