docker build -f ./client/Dockerfile -t asikrasool/multi-client:latest -t asikrasool/multi-client:$SHA ./client
docker build -f ./server/Dockerfile -t asikrasool/multi-server:latest -t asikrasool/multi-server:$SHA ./server
docker build -f ./worker/Dockerfile -t asikrasool/multi-worker:latest -t asikrasool/multi-worker:$SHA ./worker

docker push asikrasool/multi-client:latest
docker push asikrasool/multi-client:$SHA

docker push asikrasool/multi-server:latest
docker push asikrasool/multi-server:$SHA

docker push asikrasool/multi-worker:latest
docker push asikrasool/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=asikrasool/multi-client:$SHA
kubectl set image deployments/server-deployment server=asikrasool/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=asikrasool/multi-worker:$SHA
