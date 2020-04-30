#!/usr/bin/env bash

: ${1?'missing key directory'}

key_dir="$1"

chmod 0700 "$key_dir"
cd "$key_dir"

# Generate the CA cert and private key
openssl req -nodes -new -x509 -keyout ca.key -out ca.crt -subj "/CN=Admission Controller Webhook Demo CA"

# Generate the private key for the webhook server
openssl genrsa -out tls.key 2048

### TODO: get from parameters
openssl req -new -key tls.key -subj "/CN=admission-webhook-server.admission-webhooks.svc" | openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -out tls.crt
