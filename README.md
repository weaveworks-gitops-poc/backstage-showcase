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
# (Optional) Provide the base URL to the weave-gitops app to link through from resources displayed in Backstage.
WEAVE_GITOPS_URL=http://localhost:9001 ./startup.sh
```

To uninstall, run the uninstall script (which will remove the backstage namespace).

```sh
./uninstall.sh
```

## _(optional)_ Install `weave-gitops` to demonstrate linking through to resources details

Backstage shows the important information about each resource, you can click through to the weave-gitops UI to see even more details. The URL is provided by the `WEAVE_GITOPS_URL` environment variable as shown above.

Follow the weave-gitops [installation instructions](https://docs.gitops.weave.works/docs/next/open-source/getting-started/install-OSS/).

In short:

> ```sh
> brew tap weaveworks/tap
> brew install weaveworks/tap/gitops
> gitops create dashboard ww-gitops --password="some-password"
> kubectl port-forward svc/ww-gitops-weave-gitops -n flux-system 9001:9001
> ```

Login to http://localhost:9001 with the username `admin` and the password you provided when creating the dashboard.
