[Backstage](https://backstage.io)
=================================

This is a Demo Backstage application.

Prerequisites:

You will need a GitHub account, and a Kubernetes cluster.

# Running Locally

You will need to create a GitHub Oauth Client ID and Secret, follow the instructions [here](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app) to create one.

The [Backstage GitHub provider](https://backstage.io/docs/auth/github/provider/) provides details on the Authorization callback URL.

Then run the installation script:

```sh
./install.sh <insert GitHub Oauth client id> <insert GitHub Oauth client secret>
```

To start the app, run:

```sh
./startup.sh
```

To uninstall, run the uninstall script (which will remove the backstage namespace).

```sh
./uninstall.sh
```
