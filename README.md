# Next.js -> Docker -> GHCR -> Kubernetes (Minikube)

This repo contains a minimal Next.js app, Dockerfile, GitHub Actions workflow to push images to GitHub Container Registry (GHCR), and Kubernetes manifests for deployment on Minikube.

## Files
- `Dockerfile` — multi-stage production image
- `.github/workflows/ci-cd-ghcr.yml` — build & push to GHCR on push to `main`
- `k8s/deployment.yaml`, `k8s/service.yaml` — Kubernetes manifests
- `pages/api/health.js` — health endpoint
- `pages/index.js` — simple index page

---

## Quick local run (dev)
```bash
# Install deps locally and dev run
npm install
npm run dev
# open http://localhost:3000
```
## Setup Instructions

Follow these steps to set up your environment and deploy the Next.js application:

### 1. Install Docker

```sh
sudo apt-get install docker.io -y
sudo gpasswd -a toufik docker
```

### 2. Create and Configure User

```sh
adduser toufik
usermod -aG sudo toufik
```

Grant passwordless sudo access to the user `toufik`:

```sh
sudo visudo
# Add the following line:
toufik ALL=(ALL:ALL) NOPASSWD: ALL

# Alternatively, create a sudoers file for toufik:
sudo visudo -f /etc/sudoers.d/toufik
# Add the same line:
toufik ALL=(ALL:ALL) NOPASSWD: ALL
```

### 3. Install kubectl

```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

### 4. Install Minikube

```sh
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
minikube start
```

### 5. Deploy the Application

```sh
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

## How to Access the Deployed Application

After deploying your Next.js application to Kubernetes, you can access it in several ways:

### 1. Using Minikube

To get the URL for your service running in Minikube, use:
```sh
minikube service nextjs-service --url
```
This will output a URL you can open in your browser.

### 2. Using kubectl Port Forwarding

You can forward a local port to your Kubernetes service with:
```sh
kubectl port-forward service/nextjs-service 3000:80 --address 0.0.0.0
```
Then, access the application at:  
`http://localhost:3000`  
Or, if running on a remote server (e.g., EC2), use:  
`http://<ec2-ip>:3000`

Replace `<ec2-ip>` with your actual EC2 instance public IP address.
