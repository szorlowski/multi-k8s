docker build -t anananaski/multi-client:latest -t anananaski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anananaski/multi-server:latest -t anananaski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anananaski/multi-worker:latest -t anananaski/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anananaski/multi-client:latest
docker push anananaski/multi-server:latest
docker push anananaski/multi-worker:latest

docker push anananaski/multi-client:$SHA
docker push anananaski/multi-server:$SHA
docker push anananaski/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=anananaski/multi-server:$SHA
kubectl set image deployments/client-deployment client=anananaski/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anananaski/multi-worker:$SHA