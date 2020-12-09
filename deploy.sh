docker build -t posija/multi-client:latest -t posija/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t posija/multi-server:latest -t posija/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t posija/multi-worker:latest -t posija/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push posija/multi-client:latest
docker push posija/multi-server:latest
docker push posija/multi-worker:latest

docker push posija/multi-client:latest:$SHA
docker push posija/multi-server:latest:$SHA
docker push posija/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=posija/multi-server:$SHA
kubectl set image deployments/client-deployment server=posija/multi-client:$SHA
kubectl set image deployments/worker-deployment server=posija/worker-client:$SHA