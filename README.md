# ⛅ VPC terraform infra

Тут описано начальное состояние облака VPC и немного k8s конфига.

## 🌳 Структура репозитория

Манифесты terraform разбиты на модули и каждый модуль отвечает
за определённую часть облака VPC:

```
.
├── main.tf
├── modules
│   ├── dns
│   │   ├── main.tf
│   │   └── vars.tf
│   ├── k8s
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── vars.tf
│   ├── mks
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── vars.tf
│   └── vpc
│       ├── main.tf
│       ├── output.tf
│       └── vars.tf
├── providers.tf
└── vars.tf
```

Процесс разворачивания следующий:

- создаём проект в VPC
- создаём MKS-кластер в этом проекте
- создаём группу нод для MKS-кластера
- разворачиваем ingress-контроллер в MKS-кластере
- создаём wildcard A-запись для floating-ip балансировщика
  (который появился вместе с ingress-контроллером)

## ⚓ Переменные и их умолчания

| Переменная                          | Дефолтное значение | Примечание                                   |
|:----------------------------------- |:------------------ |:-------------------------------------------- |
| `sel_token`                         | `""`               | Токен для управлениями ресурсами в VPC       |
| `project_name`                      | `infra`            | Имя проекта в VPC                            |
| `user_name`                         | `infra_user`       | Имя пользователя в VPC                       |
| `user_password`                     | `""`               | Пароль пользователя в VPC                    |
| `domain_name`                       | `shatoh.in`        | Имя домена для добавления в панель           |
| `cluster_name`                      | `cluster-01`       | Имя кластера MKS                             |
| `region`                            | `ru-3`             | Регион VPC для создания ресурсов             |
| `kube_version`                      | `1.18.20`          | Версия K8S в MKS-кластере                    |
| `enable_autorepair`                 | `true`             | Автовосстановление нод MKS-кластера          |
| `enable_patch_version_auto_upgrade` | `true`             | Автообновление патч-версий                   |
| `availability_zone`                 | `ru-3a`            | Зона выбранного региона VPC                  |
| `nodes_count`                       | `2`                | Количество нод MKS-кластера                  |
| `cpus`                              | `2`                | Количество ядер у каждой ноды в MKS-кластере |
| `ram_mb`                            | `2048`             | Количество ОЗУ у каждой ноды в MKS-кластере  |
| `volume_gb`                         | `16`               | Объём диска у каждой ноды в MKS-кластере     |
| `volume_type`                       | `fast.ru-3a`       | Тип диска каждой ноды в MKS-кластере         |

## 🚀 S3 как tf-state

Для хранения `tf-state` используем [S3](https://www.terraform.io/docs/language/settings/backends/s3.html).

## 🏗 CI/CD для инфраструктуры

To DO

## 🤙 Ingress-контроллер

Используем модный 😍[Contour-ingress](https://projectcontour.io)
построенные на молодёжном 🤩[Envoy](https://www.envoyproxy.io)
