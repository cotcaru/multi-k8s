docker built -t cotcaru/multi-client:latest -t cotcaru/multi-client:$SHA ./client/Dockerfile ./client
docker built -t cotcaru/multi-server:latest -t cotcaru/multi-server:$SHA ./server/Dockerfile ./server
docker built -t cotcaru/multi-worker:latest -t cotcaru/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push cotcaru/multi-client:latest
docker push cotcaru/multi-server:latest
docker push cotcaru/multi-worker:latest
docker push cotcaru/multi-client:$SHA
docker push cotcaru/multi-server:$SHA
docker push cotcaru/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cotcaru/multi-server:$SHA
kubectl set image deployments/client-deployment server=cotcaru/multi-client:$SHA
kubectl set image deployments/worker-deployment server=cotcaru/multi-worker:$SHA