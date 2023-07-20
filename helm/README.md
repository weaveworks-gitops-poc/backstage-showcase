# Deploying via a HelmRelease

This installation is only intended for demo purposes, this does not configure a production-ready Backstage installation.

For example, the database is configured to be sqlite3 rather than the recommended PostgreSQL.

It's recommended that you read the the Backstage [instructions](https://backstage.io/docs/deployment/docker/), this document is not a replacement for this.

## Building with the Makefile

Alternatively, you can build the container image with 

```console
$ IMG=ghcr.io/my-user/my-repo:my-tag BASE_URL=https://backstage.example.com make docker-build docker-push
```

This will follow the build instructions in the Backstage Docker page and create an image and push it.

## Deploying with the Backstage Helm Chart

In this directory, there is a `helm-repository.yaml` this contains the Helm chart for the official Backstage [Helm chart](https://github.com/backstage/charts).

There is also an example `helm-release.yaml` that provides a Flux [HelmRelease](https://fluxcd.io/flux/components/helm/helmreleases/) that can be configured to deploy the build Helm chart.

See the [README](../) for how to create a GitHUb OAuth client and secret.

Create a secret...

```console
export GITHUB_CLIENT_ID=<insert client id>
export GITHUB_CLIENT_SECRET=<insert client secret>
export GITHUB_TOKEN=<insert github PAT token>

kubectl create secret generic backstage-oauth-secret -n backstage \
  --from-literal=AUTH_GITHUB_CLIENT_ID=$GITHUB_CLIENT_ID \
  --from-literal=AUTH_GITHUB_CLIENT_SECRET=$GITHUB_CLIENT_SECRET \
  --from-literal=GITHUB_TOKEN=$GITHUB_TOKEN \
```

Update the `helm-release.yaml` to fix the image repository and version.

## Apply the HelmRepository and HelmRelease

**You must update the provided HelmRelease** the file in `helm/helm-release.yaml` is just an example.

```yaml
    backstage:
      image:
        registry: # e.g. docker.io
        repository: # my-user/my-image
        tag: # tag you used when building the docker image e.g. 3af880b
```

```console
$ kubectl apply -k helm
```

## (Optional) Create a ConfigMap with the Backstage app-config.yaml

The provided HelmRelease optionally depends on a `ConfigMap` with the additional configuration for the deployment.

```console
$ helm/update-config.sh
```

This provides an easy way to override the Backstage setup.

By default `app-config.kubernetes.yaml` is baked into the container, so you may not need to change anything.

If you want to apply additional configuration, you must enable the ConfigMap in the HelmRelease.

```yaml
      # extraAppConfig:
      #   - filename: app-config.local.yaml
      #     configMapRef: backstage-app-config
```
