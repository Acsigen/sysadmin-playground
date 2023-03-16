# OpenSSL

## Check certificate signature

Check if a certificate was signed with a specific key:

```bash
openssl x509 -in webserver-cert.pem -pubkey -noout -outform pem | sha256sum && \
openssl pkey -in webserver-key.pem -pubout -outform pem | sha256sum
```

If the hashes match, everything is fine. If not, the certificate was not signed with that key.
