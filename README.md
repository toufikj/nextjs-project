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
