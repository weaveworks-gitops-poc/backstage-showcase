# [Backstage](https://backstage.io)

This is a Demo Backstage application.

## Prerequisites:

You will need a GitHub account, and a Kubernetes cluster with a bare minimum of [Flux](https://fluxcd.io/) installed.

**NOTE:** Please ensure you're running a recent version of Flux, supported versions are > 2.0.0

If you don't have Flux installed this will install the minimum set of resources:

```sh
flux install --components source-controller,kustomize-controller,helm-controller
```

You will also need an active LTS release of `node.js` installed on your local machine, i.e. you must have Node 16 or 18 installed.

```console
$ node --version
v18.16.0
```

See the [Backstage instructions](https://backstage.io/docs/getting-started/) on how to install a suitable version if you don't have it installed.

## Demo Kubernetes Resources

* The "Catalogue Service"
  * [HelmRelease](http://localhost:3000/catalog/default/component/catalogue-service)
  * [Deployment](http://localhost:3000/catalog/default/component/catalogue-service/kubernetes) with Pod Logs
  * [HelmRepository](http://localhost:3000/catalog/default/component/catalogue-service/weaveworks-flux)
* The "Carts Service"
  * [CronJob](http://localhost:3000/catalog/default/component/carts-service/kubernetes)
* The "Payment Service"
  * [CronJob](http://localhost:3000/catalog/default/component/payments-service/kubernetes) which has Pod Logs and will always fail.
* The "Orders Service"
  * [Verified OCI Repository](http://localhost:3000/catalog/default/component/orders-service/weaveworks-flux)
* The "Shipping Service"
  * [Verified Git Repository](http://localhost:3000/catalog/default/component/shipping-service/weaveworks-flux) and Kustomization

## Running Locally

You will need to create a GitHub Oauth Client ID and Secret, follow the instructions [here](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app) to create one.

The [Backstage GitHub provider](https://backstage.io/docs/auth/github/provider/) provides details on the Authorization callback URL.

Then run the installation script with 2 arguments:

```sh
./install.sh <insert GitHub Oauth client id> <insert GitHub Oauth client secret>
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
