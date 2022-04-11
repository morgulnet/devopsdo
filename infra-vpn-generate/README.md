# Terraform infra for Yandex cloud

## 1. Network

Поднимаем сети, 3 публичных с белыми айпи и 3 приватных с интернетом через nat.
Тестовую виртуалку для теста nata.

Scurity group:
http-https-traffic allow 80,443
wireguard-traffic allow 51820
allow-all ,block-all
defaluf allow 22 from wireguard, allow all inside trafic

## 2. Generic , wireguard modules

Добавлен generic модуль
Добавлен wireguard модуль

## 3. DNS

Добавлена зона devopsdo, и А запись для test.devopsdo указывающая на vm test 
PING test.devopsdo (192.168.101.31) 56(84) bytes of data.
64 bytes from fhmbss89l4164j3rneq1.auto.internal (192.168.101.31): icmp_seq=1 ttl=63 time=1.29 ms

## 4. add S3

Добавлен модуль s3.
Описано кодом создание бакетов для стейта терраформа и бакета для всего подряд.

## 5. Add Gitops 

Добавлен flux2 
Манифесты nginx inress controller, namespaces

## 6. Добавлены svc , internal lb, DNS 
Можно зайти на сервис с включенным vpn
http://hotrod.k8s.dev.devops.do
Добавлен wildcard dns record
*.k8s.dev.devops.do

## 7. Добавлен фолдер .ca
Генерация корневого ,промежуточного (intermediate vault),клиентского (vault) сертификатов 

## TODO
Выенсти терраформ стейт на s3
на момент инициализации бакета не существует

DB on vm
кроссклауд возможен только на бареметале

vault (db need)
PKI
secrets in k8s

certmanager (need vault pki)

istio
flagger Progressive Delivery (need istio)

consul
All services in registry

metrics 
logs efk

ldap
keycloak

WAF

cicd
