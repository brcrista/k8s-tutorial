NAME := hello-node
IMAGE_VERSION := 1.0
PORT := 8080

.PHONY: all
all: dockerfile deploy

.PHONY: dockerfile
dockerfile:
	eval $(minikube docker-env)
	docker build . --tag $(NAME):$(IMAGE_VERSION)

.PHONY: deploy
deploy:
	kubectl apply -k kustomize

.PHONY: clean
clean:
	kubectl delete service,deployment $(NAME)