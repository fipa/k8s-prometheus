docker-build-all: docker-build-api docker-build-consumer docker-build-front docker-build-publisher

k8s-apply-all: k8s-apply-api k8s-apply-consumer k8s-apply-front k8s-apply-publisher k8s-apply-database k8s-apply-prometheus k8s-apply-rabbitmq


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

k8s-apply-prometheus:
	microk8s kubectl apply -f prometheus/prometheus.yaml

k8s-apply-prometheus2:
	microk8s kubectl apply -f prometheus2/namespace.yaml
	microk8s kubectl apply -f prometheus2/prometheus-config.yaml
	microk8s kubectl apply -f prometheus2/prometheus-deployment.yaml
	microk8s kubectl apply -f prometheus2/prometheus-service.yaml

k8s-apply-rabbitmq:
	microk8s kubectl apply -f rabbitmq/rabbitmq.yaml

dashboard-start:
	microk8s dashboard-proxy

k8s-delete-all:
	microk8s kubectl delete -f api/api.yaml
	microk8s kubectl delete -f consumer/consumer.yaml
	microk8s kubectl delete -f front/front.yaml
	microk8s kubectl delete -f publisher/publisher.yaml
	microk8s kubectl delete -f database/postgresql.yaml
	microk8s kubectl delete -f prometheus/prometheus.yaml
	microk8s kubectl delete -f rabbitmq/rabbitmq.yaml