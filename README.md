# devopsdo
infrastructure as code in Yandex cloud.

Инфраструктура как код в яндекс облаке.

На даннном этапе создаеться инфраструктура в которой работают 
kubernetes cluster ,vm , и менеджед ресурсы.

После создания кластера с помощью flux2 устанавливаються nginx ingress cntroller и создаеться запись днс для его сервиса.

Доступ к внутренним сетям через wireguard.

Для работы необходима утилита yc.
https://cloud.yandex.ru/docs/cli/operations/install-cli

Переменные
Данные для доступа к yandex cloud
export TF_VAR_cloud_id=
export TF_VAR_folder_id=
export TF_VAR_token=

Данные для доступа к гитхабу (gitops module)
export TF_VAR_github_owner=
export TF_VAR_github_token=

Список уже сделанного и todo лист /infra-vpn-generate/README.md