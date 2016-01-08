FROM debian:stable
MAINTAINER Lance Chen <cyen0312@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV VAULT_VERSION 0.4.0
ENV VAULT_CHECKSUM_FILENAME vault_${VAULT_VERSION}_SHA256SUMS
ENV VAULT_CHECKSUM_SIGNATURE_FILENAME vault_${VAULT_VERSION}_SHA256SUMS.sig
ENV VAULT_FILENAME vault_${VAULT_VERSION}_linux_amd64.zip
ENV HASHICORP_SECURITY_GPG_KEY 91A6E7F85D05C65630BEF18951852D87348FFC4C

RUN apt-get update \
    && apt-get install -y curl unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN gpg --keyserver hkp://pgp.mit.edu --recv-keys $HASHICORP_SECURITY_GPG_KEY \
    && curl -q -O https://releases.hashicorp.com/vault/${VAULT_VERSION}/{$VAULT_CHECKSUM_FILENAME,$VAULT_CHECKSUM_SIGNATURE_FILENAME,$VAULT_FILENAME} \
    && gpg --verify $VAULT_CHECKSUM_SIGNATURE_FILENAME \
    && grep $VAULT_FILENAME $VAULT_CHECKSUM_FILENAME | sha256sum -c - \
    && unzip $VAULT_FILENAME vault -d /usr/local/bin/

ADD vault.hcl /usr/local/etc/vault

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["server", "-config", "/usr/local/etc/vault"]
