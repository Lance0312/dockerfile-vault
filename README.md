Dockerfile for Hashicorp Vault
==============================

### Pull the image
```bash
$ docker pull lancechen/vault
```

### Start a Vault server

An in-memory backend configuration is shipped with this docker image for testing only.
For production environment, it is highly recommended to override the default configuration
file with a customized one. Checkout https://vaultproject.io/docs/config/index.html for
details on writing configuration files.

#### Start a dev server

```bash
$ docker run -d -p 8200:8200 --name dev-vault lancechen/vault
```

#### Start a dev server with a customized config file

```bash
$ docker run -d -p 8200:8200 --name vault -v myvault.hcl:/usr/local/etc/vault lancechen/vault
```
