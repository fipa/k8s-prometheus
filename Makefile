#####################################################################################################
# Description: Makefile for building and deploying the k8s project

# Usage:
# make docker-build-all: Build all docker images and push them to the microk8s registry.
# make k8s-init: Initialize microk8s.
# make k8s-apply-all: Deploy all services.
# make k8s-delete-all: Delete all services.

# Author: Fernando Poblete Arrau
#####################################################################################################

# Grouped commands
k8s-init:
	microk8s enable dns
	microk8s enable registry
	microk8s enable rbac
	microk8s enable dashboard

docker-build-all: docker-build-api docker-build-consumer docker-build-front docker-build-publisher

k8s-apply-all: k8s-apply-api k8s-apply-consumer k8s-apply-front k8s-apply-publisher k8s-apply-database k8s-apply-rabbitmq

k8s-delete-all:
	microk8s kubectl delete -f api/api.yaml
	microk8s kubectl delete -f consumer/consumer.yaml
	microk8s kubectl delete -f front/front.yaml
	microk8s kubectl delete -f publisher/publisher.yaml
	microk8s kubectl delete -f database/postgresql.yaml
	microk8s kubectl delete -f rabbitmq/rabbitmq.yaml

# Docker commands per component
docker-build-api:
	docker build -t localhost:32000/k8s_api:latest api
	docker push localhost:32000/k8s_api:latest

docker-build-consumer:
	docker build -t localhost:32000/k8s_consumer:latest consumer
	docker push localhost:32000/k8s_consumer:latest

docker-build-front:
	docker build -t localhost:32000/k8s_front:latest front
	docker push localhost:32000/k8s_front:latest

docker-build-publisher:
	docker build -t localhost:32000/k8s_publisher:latest publisher
	docker push localhost:32000/k8s_publisher:latest


# K8s commands per component

k8s-apply-api:
	microk8s kubectl apply -f api/api.yaml

k8s-apply-consumer:
	microk8s kubectl apply -f consumer/consumer.yaml

k8s-apply-front:
	microk8s kubectl apply -f front/front.yaml

k8s-apply-publisher:
	microk8s kubectl apply -f publisher/publisher.yaml

k8s-apply-database:
	microk8s kubectl apply -f database/postgresql.yaml

k8s-apply-rabbitmq:
	microk8s kubectl apply -f rabbitmq/rabbitmq.yaml


# Prometheus
k8s-apply-prometheus:
	microk8s helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	microk8s helm repo update
	microk8s kubectl apply -f prometheus/namespace.yaml
	microk8s helm install prometheus-operator prometheus-community/kube-prometheus-stack --namespace monitoring -f prometheus/values.yaml
	

k8s-delete-prometheus:
	microk8s kubectl delete -f prometheus/namespace.yaml

# Run dashboard, in a separate terminal
k8s-dashboard:
	microk8s dashboard-proxy
