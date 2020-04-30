# k8s Admission controller boilerplate

## How to

1. Build image & push

```
docker build -t <repo>/admission-controller:latest -f src/admission-controller.Dockerfile src/
docker push <repo>/admission-controller:latest
```

2. Deploy!

```
./scripts/deploy.sh
```

