docker build -t thilanse96/multi-client:latest -t thilanse96/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thilanse96/multi-server:latest -t thilanse96/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thilanse96/multi-worker:latest -t thilanse96/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thilanse96/multi-client:latest
docker push thilanse96/multi-server:latest
docker push thilanse96/multi-worker:latest

docker push thilanse96/multi-client:$SHA
docker push thilanse96/multi-server:$SHA
docker push thilanse96/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=thilanse96/multi-server:$SHA
kubectl set image deployments/client-deployment client=thilanse96/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thilanse96/multi-worker:$SHA