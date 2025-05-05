#Run this from PowerShell or Windows Terminal:
wsl
#ls -l /var/run/docker.sock
#docker ps
kubectl apply -f jenkins.yml
kubectl port-forward svc/jenkins 8080:8080
