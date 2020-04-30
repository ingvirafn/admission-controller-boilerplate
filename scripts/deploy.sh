#!/usr/bin/env bash


set -euo pipefail

basedir="$(dirname "$0")"
keydir="$(dirname "$0")/../keys"

# Generate keys
if test -f "$keydir/tls.crt"; then
    echo "Certificate exists, not creating"
else
    echo "Generating TLS keys ..."
    "${basedir}/generate-keys.sh" "$keydir"
fi

ca_pem_b64="$(openssl base64 -A <"${keydir}/ca.crt")"
tls_crt_b64="$(openssl base64 -A <"${keydir}/tls.crt")"
tls_key_b64="$(openssl base64 -A <"${keydir}/tls.key")"

cmd="install"

# if [ $1 = "install" ]; then
#     cmd="install"
# fi
echo "Installing helm chart"

helm $cmd admission-controller chart/admission-controller/ --set ca_pem_b64=$ca_pem_b64 --set tls.crt=$tls_crt_b64 --set tls.key=$tls_key_b64


