# ACME DNS Auto-Renew

A Docker image to automatically renew SSL/TLS certificates using the Let's Encrypt ACME client (LEGO).
The image uses the DNS method for domain ownership validation and thus supports wildcard certificates.
Only a single certificate will be requested.
If multiple domains are passed the first domain will be used as the `MAIN` domain and all other domains will be `SANs` (Subject Alternative Names).

## Example Usage

As this image uses the DNS validation method. Set the environment variables for your DNS provider and according to the [LEGO documentation](https://go-acme.github.io/lego/dns).

For example, for GoDaddy:

```
docker run -d
  -e 'DOMAINS=example.com,www.example.com,sub.example.com,*.other.com' \
  -e 'EMAIL=email@example.com' \
  -e 'DNS_PROVIDER=godaddy' \
  -e 'GODADDY_API_KEY=xxxxxxxx' \
  -e 'GODADDY_API_SECRET=xxxxxxxx' \
  -e 'CA_SERVER=https://acme-v02.api.letsencrypt.org/directory' \
  -v /etc/letsencrypt:/root/.lego/certificates \
  jfrohnhofen/acme-dns-autorenew
```

The container will create an account with the provided email address and attempt to request SSL/TLS certificates on startup.
It will then automatically try to renew the certificates every week.
However, Let's Encrypt will only renew certificates that are about to expire in the next 30 days.

## Secrets

The image will automatically expose all secrets as environment variables within the container.
E.g., to safely pass the `GODADDY_API_SECRET` simply create a `GODADDY_API_SECRET` secret with the secret API key as its content.
