# [Backstage](https://backstage.io)

This is a Demo Backstage application.

Prerequisites:

You will need a GitHub account, and a Kubernetes cluster with a bare minimum of [Flux](https://fluxcd.io/) installed.

If you don't have Flux installed this will install the minimum set of resources:
```sh
flux install --components source-controller,kustomize-controller,helm-controller
```

# Running Locally

You will need to create a GitHub Oauth Client ID and Secret, follow the instructions [here](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app) to create one.

The [Backstage GitHub provider](https://backstage.io/docs/auth/github/provider/) provides details on the Authorization callback URL.

Additionally [create a new GitHub personal access token](https://github.com/settings/tokens/new) with the `read:packages` scope. It's used to fetch the publicly available `@weaveworks/weave-gitops` npm package.

Then run the installation script with 3 arguments:

```sh
./install.sh <insert GitHub Oauth client id> <insert GitHub Oauth client secret> <insert GitHub personal access token>
```

To start the app, run:

```sh
./startup.sh
```

To uninstall, run the uninstall script (which will remove the backstage namespace).

```sh
./uninstall.sh
```
