# k8s-tutorial

This is my code for walking through the tutorials at https://kubernetes.io/docs/tutorials/ and elsewhere.

## Setup

```sh
minikube start
make all
minikube service hello-node
```

Then, visit http://localhost:8080. It should display the text "Hello world".

## Troubleshooting

### minikube start
- I installed `kubectl` and `minikube` through `brew`. When doing the [Hello Minikube tutorial](https://kubernetes.io/docs/tutorials/hello-minikube/), `minikube start` complained about my `kubectl` version not being up-to-date. I [installed through `curl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-macos) and got the most recent version.

- When trying to run `kubectl create deployment hello-node ...`, the deployment would fail to pull from GCR with a "connection refused" error.
    - I tried to `docker pull` the image directly and it succeeded.
    - I noticed that when I do `minikube start`, I get this warning:

```
$ minikube start
😄  minikube v1.7.2 on Darwin 10.15.3
✨  Using the hyperkit driver based on existing profile
⌛  Reconfiguring existing host ...
🏃  Using the running hyperkit "minikube" VM ...
⚠️   Node may be unable to resolve external DNS records
⚠️   VM is unable to access k8s.gcr.io, you may need to configure a proxy or set --image-repository
🐳  Preparing Kubernetes v1.17.3 on Docker 19.03.6 ...
🚀  Launching Kubernetes ... 
🌟  Enabling addons: dashboard, default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube"
```

I tried doing `minikube start --vm-driver=vmware` and that fixed it.  I had to install the VMWare Minikube driver with `brew install docker-machine-driver-vmware`.

### kubectl expose

I found that port `8080` was being used by nginx.
I found and fixed this with

```sh
lsof -i :8080 # shows nginx
ps -x | grep nginx
kill # PID of nginx
```

### Deploying a local Docker image
I tried to deploy with a Docker image I had built locally.
`kubectl create deployment` wouldn't ever find the local image.
I learned that Minikube actually runs in its own VM.
`kubectl` is looking there, not on your local machine.
- You can use `minikube ssh` to SSH into this VM.
- Running `eval $(minikube docker-env)` fixed this.