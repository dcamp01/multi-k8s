docker build -t djxc65/multi-client:latest -t djxc65/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t djxc65/multi-server:latest -t djxc65/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t djxc65/multi-worker:latest -t djxc65/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push djxc65/multi-client:latest
docker push djxc65/multi-server:latest
docker push djxc65/multi-worker:latest
#different tags need to be pushed separately
docker push djxc65/multi-client:$SHA
docker push djxc65/multi-server:$SHA
docker push djxc65/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=djxc65/multi-server:$SHA
kubectl set image deployments/client-deployment client=djxc65/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=djxc65/multi-worker:$SHA
