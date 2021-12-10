docker build -t asikrasool/multi-client:latest -t asikrasool/multi-client:$SHA -f ./client/Dockerfile -f ./client
docker build -t asikrasool/multi-server:latest -t asikrasool/multi-server:$SHA -f ./server/Dockerfile -f ./server
docker build -t asikrasool/multi-worker:latest -t asikrasool/multi-worker:$SHA -f ./worker/Dockerfile -f ./worker

docker push asikrasool/multi-client:latest
docker push asikrasool/multi-client:$SHA

docker push asikrasool/multi-server:latest
docker push asikrasool/multi-server:$SHA

docker push asikrasool/multi-worker:latest
docker push asikrasool/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployments server=asikrasool/multi-client:$SHA
kubectl set image deployments/server-deployments server=asikrasool/multi-server:$SHA
kubectl set image deployments/worker-deployments server=asikrasool/multi-worker:$SHA
