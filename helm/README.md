# Deploying via a HelmRelease

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
