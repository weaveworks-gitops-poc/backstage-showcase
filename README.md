[Backstage](https://backstage.io)
=================================

This is a Demo Backstage application.

Prerequisites:

You will need a GitHub account, and a Kubernetes cluster.

# Running Locally

First of all, apply the Kubernetes resources in the `./kubernetes` directory with:
```sh
kubectl apply -k kubernetes/
```
This will create a namespace `backstage` along with a `ClusterRole` and `ServiceAccount`.

You will need to create a GitHub Oauth Client ID and Secret, follow the instructions [here](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app) to create one.

Then create a Kubernetes Secret with this.
```sh
kubectl create secret generic backstage-oauth-secret -n backstage --from-literal=GITHUB_CLIENT_ID=<insert client ID>a --from-literal=GITHUB_CLIENT_SECRET=<insert client secret>
```

To start the app, run:

```sh
./startup.sh
```
