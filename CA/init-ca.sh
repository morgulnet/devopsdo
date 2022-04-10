#!/usr/bin/env bash
set -eu

CA_NAME=${1}

if [ -f ${HOME}/.ca/.${CA_NAME} ]; then
    source ${HOME}/.ca/.${CA_NAME}
else
    echo ${HOME}/.ca/.${CA_NAME} not found
    exit 1
fi

CADIR=${HOME}/.ca/${CA_NAME}
mkdir -p ${CADIR} && cd ${CADIR}

# init subdirectories, index.txt and serial files:
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

# write the root CA config:
tee openssl.cnf >/dev/null <<EOF
# OpenSSL root CA configuration file.

[ ca ]
# man ca
default_ca = CA_default

[ CA_default ]
# Directory and file locations.
dir               = ${CADIR}
certs             = \$dir/certs
crl_dir           = \$dir/crl
new_certs_dir     = \$dir/newcerts
database          = \$dir/index.txt
serial            = \$dir/serial
RANDFILE          = \$dir/private/.rand

# The root key and root certificate.
private_key       = \$dir/private/ca.key.pem
certificate       = \$dir/certs/ca.cert.pem

# For certificate revocation lists.
crlnumber         = \$dir/crlnumber
crl               = \$dir/crl/ca.crl.pem
crl_extensions    = crl_ext
default_crl_days  = 30

# SHA-1 is deprecated, so use SHA-2 instead.
default_md        = sha256

name_opt          = ca_default
cert_opt          = ca_default
default_days      = ${DEFAULT_DAYS}
preserve          = no
policy            = policy_strict

[ policy_strict ]
# The root CA should only sign intermediate certificates that match.
# See the POLICY FORMAT section of 'man ca'.
countryName             = match
stateOrProvinceName     = match
organizationName        = match
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ policy_loose ]
# Allow the intermediate CA to sign a more diverse range of certificates.
# See the POLICY FORMAT section of the 'ca' man page.
countryName             = optional
stateOrProvinceName     = optional
localityName            = optional
organizationName        = optional
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ req ]
# Options for the 'req' tool ('man req').
default_bits        = ${DEFAULT_BITS}
distinguished_name  = req_distinguished_name
string_mask         = utf8only

# SHA-1 is deprecated, so use SHA-2 instead.
default_md          = sha256

# Extension to add when the -x509 option is used.
x509_extensions     = v3_ca

[ req_distinguished_name ]
# See <https://en.wikipedia.org/wiki/Certificate_signing_request>.
countryName                     = Country Name (2 letter code)
stateOrProvinceName             = State or Province Name
localityName                    = Locality Name
0.organizationName              = Organization Name
organizationalUnitName          = Organizational Unit Name
commonName                      = Common Name
emailAddress                    = Email Address

# Optionally, specify some defaults.
countryName_default             = ${CA_DN_DEFAULT_COUNTRY_CODE}
stateOrProvinceName_default     = "${CA_DN_DEFAULT_STATE_OR_PROVINCE}"
localityName_default            = "${CA_DN_DEFAULT_LOCALITY}"
0.organizationName_default      = "${CA_DN_DEFAULT_ORG}"
organizationalUnitName_default  = "${CA_DN_DEFAULT_ORG_UNIT}"
emailAddress_default            = "${CA_DN_DEFAULT_EMAIL_ADDRESS}"

[ v3_ca ]
# Extensions for a typical CA ('man x509v3_config').
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ v3_intermediate_ca ]
# Extensions for a typical intermediate CA ('man x509v3_config').
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true, pathlen:0
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ usr_cert ]
# Extensions for client certificates ('man x509v3_config').
basicConstraints = CA:FALSE
nsCertType = client, email
nsComment = "${NS_CLIENT_CERT_COMMENT}"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
keyUsage = critical, nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, emailProtection

[ server_cert ]
# Extensions for server certificates ('man x509v3_config').
basicConstraints = CA:FALSE
nsCertType = server
nsComment = "${NS_SERVER_CERT_COMMENT}"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth

[ crl_ext ]
# Extension for CRLs ('man x509v3_config').
authorityKeyIdentifier=keyid:always

[ ocsp ]
# Extension for OCSP signing certificates ('man ocsp').
basicConstraints = CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
keyUsage = critical, digitalSignature
extendedKeyUsage = critical, OCSPSignings
EOF

# generate root CA:
openssl genrsa -aes256 -out ${CADIR}/private/ca.key.pem 4096
chmod 400 ${CADIR}/private/ca.key.pem
openssl req -config ${CADIR}/openssl.cnf \
      -key ${CADIR}/private/ca.key.pem \
      -new -x509 -days ${DEFAULT_CA_DAYS} -sha256 -extensions v3_ca \
      -out ${CADIR}/certs/ca.cert.pem
chmod 444 ${CADIR}/certs/ca.cert.pem
openssl x509 -noout -text -in ${CADIR}/certs/ca.cert.pem

