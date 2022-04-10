https://gruchalski.com/posts/2020-09-09-multi-tenant-vault-pki-with-custom-root-pem-bundle/

export DEFAULT_CA_DAYS=1826
~/.ca/init-ca.sh devopsdo-ca

Validity
            Not Before: Mar 12 13:29:38 2022 GMT
            Not After : Mar 12 13:29:38 2027 GMT

export DEFAULT_CA_DAYS=730
./init-intermediate.sh devopsdo-ca intermediate-vault-devopsdo

Validity
            Not Before: Mar 12 13:30:48 2022 GMT
            Not After : Mar 11 13:30:48 2024 GMT

Порядок генерации сертификата для vault.mos.corp

openssl genrsa -out tls.key 4096
openssl req -out vault.csr -key tls.key -new -sha256 -subj "/C=RU/ST=Moscow/L=Moscow/O=devops.do, Inc./CN=vault.devops.do"
openssl x509 -req -sha256 -extfile <(printf "subjectAltName=DNS:localhost,DNS:vault.vault.svc,DNS:*.vault-internal,DNS:vault.devops.do") -days 365 -in vault.csr -CA intermediate/intermediate-vault-devopsdo/certs/intermediate.cert.pem -CAkey intermediate/intermediate-vault-devopsdo/private/intermediate.key.pem -CAcreateserial -out tls.crt

Как сравнить хэши ключа и сертификата
openssl x509 -noout -modulus -in tls.crt| openssl md5
openssl rsa -noout -modulus -in tls.key| openssl md5

Как посмотреть информацию о сертификате
openssl x509 -in tls.crt -text -noout

kubectl create secret generic vault-certs --from-file=rootCA.crt=certs/ca.cert.pem --from-file=tls.crt=tls.crt --from-file=tls.key=tls.key

Add rootCA.crt and intermediateCA.crt to tls.crt
kubectl get secret vault-certs -o yaml > vault-certs.yaml 
Crear metada like creationTimestamp: ,resourceVersion: ,uid:
