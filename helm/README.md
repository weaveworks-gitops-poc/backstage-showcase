# Deploying via a HelmRelease

This installation is only intended for demo purposes, this does not configure a production-ready Backstage installation.

For example, the database is configured to be sqlite3 rather than the recommended PostgreSQL.

It's recommended that you read the the Backstage [instructions](https://backstage.io/docs/deployment/docker/), this document is not a replacement for this.

## Building the Dockerfile

From this repository root:

```console
$ yarn build:backend
...
app:    182 B (-40 B)         dist/static/6447.f98d7814.chunk.js
app:
Moving backend into dist workspace
Moving app into dist workspace
✨  Done in 122.35s.
```

Then build a Docker container image:

```console
$ docker image build -t INSERT_IMAGE_REFERENCE -f packages/backend/Dockerfile .
```

**Push the Docker container image**

```console
$ docker push INSERT_IMAGE_REFERENCE
```

## Deploying with the Backstage Helm Chart

See the [README](../) for how to create a GitHUb OAuth client and secret.

Create a secret...

```console
export GITHUB_CLIENT_ID=<insert client id>
export GITHUB_CLIENT_SECRET=<insert client secret>
export GITHUB_TOKEN=<insert github PAT token>
export BASE_URL=<insert url to access backstage e.g.  https://backstage.example.com>

kubectl create secret generic backstage-oauth-secret -n backstage \
  --from-literal=AUTH_GITHUB_CLIENT_ID=$GITHUB_CLIENT_ID \
  --from-literal=AUTH_GITHUB_CLIENT_SECRET=$GITHUB_CLIENT_SECRET \
  --from-literal=GITHUB_TOKEN=$GITHUB_TOKEN \
  --from-literal=BASE_URL=$BASE_URL
```

Update the helm-release.yaml to fix the image repository and version.

## Apply the HelmRepository and HelmRelease

**You must update the provided HelmRelease** the file in helm/helm-release.yaml is just an example.

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

The provided HelmRelease depends on a ConfigMap with the app-config.yaml.

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
