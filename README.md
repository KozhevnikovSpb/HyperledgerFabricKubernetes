I.	Установка и настройка виртуальной машины.

1.	Необходимо установить и настроить подходящую систему виртуализации (Virtual Box, VMware Workstation, Proxmox, Hyper-V и др.) В данной инструкции будет использована система для виртуализации Oracle VM VirtualBox. Скачать можно по ссылке - https://www.virtualbox.org/wiki/Downloads
2.	Создать виртуальную сеть NAT со следующими параметрами
3.	Создать перенаправление портов
4.	Создаем виртуальную машину со следующими минимальными параметрами:
•	Оперативная память от 8 Gb;
•	Процессор от 6-ти ядер;
•	Жесткий диск от 45 Gb;
•	Сетевой интерфейс в режим NAT Сеть. 

5.	В качестве гостевой ОС можно использовать Ubuntu Server (желательно в самом минимальном режиме) или Debian (без дальнейшей установки GUI). При установке Ubuntu Server необходимо обратить внимание на выбор типа жесткого диска в процессе установки, он не должен иметь тип LVM. При использовании ОС Debian получается минимальный установочный размер ОС около 2 Gb, это меньше чем для ОС Ubuntu Server. 

II.	Установка ОС Debian на виртуальную машину

1.	После создания виртуальной машины нажимаем «Старт» и начинаем устанавливать гостевую ОС: 
•	На экране приветствия выбираем – Graphical install
•	Язык оставляем – English
•	Локацию можно установить – Other -> Europe -> Russian Federation
•	Конфигурацию локали оставляем и язык клавиатуры оставляем по умолчанию
•	На этапе задания Domain name, необходимо вернуться на шаг назад и сконфигурировать IP адрес вручную
  ip – 10.0.2.5
  netmask – 255.255.255.0
  gateway – 10.0.2.1
  nameserver – 10.0.2.1
•	Hostname и Domain name можно указать любой по желанию
•	Задаем пароль root, затем имя администратор и пароль для него
•	Выбираем часовой пояс
•	При разметке жесткого диска оставляем все по умолчанию – Guided – use entire disk
•	При настройке partition disks – All files in one partition
•	На заключительном этапе – соглашаемся с записью изменений на диск
•	Отказываемся от сканирования других медиа
•	Выбираем для настройки package manager все по умолчанию
•	При завершении установки оставляем в опциях только – SSH server и Standard system utilities
Обращаю внимание, если используется Ubuntu, то Docker нельзя ставить из прилагаемого списка в конце установки.
•	В конце установки соглашаемся с установкой grub и устанавливаем его в корень /dev/sda

III.	Putty и WinCSP

1.	Для работы с виртуальной машины необходимо скачать и установить:
•	Putty - https://www.putty.org/
•	WinCSP - https://winscp.net/eng/download.php
2.	Подключаться к виртуальной машине следует через адрес локальной петли 127.0.0.1

IV.	Предварительная настройка виртуальной машины

1.	После подключения необходимо поднять права до root (следует делать при каждом подключении):
~# su –
Ввести пароль от root (должен быть задан на этапе установки ОС)

2.	Отключить протокол IPv6
Открыть файл grub найти строку, в которой есть запись "GRUB_CMDLINE_LINUX", и отредактировать её
~# nano /etc/default/grub
GRUB_CMDLINE_LINUX=”ipv6.disable=1”

Закрыть файл с сохранением настроек ctrl+x, y + enter
Запустить обновление grub
~# update-grub2

3.	Отключить swap 
~# swapoff -a
Отключить swap
Открыть файл fstab, закомментировать строчку подключения swap, перезапустить ОС
~# nano /etc/fstab
~# reboot

После перезагрузки перезапускаем сессию Putty, заново авторизуемся и поднимаем свои права до root

Проверить статус swap
~# systemctl --type swap

4.	Создать папку для хранения исходных файлов проекта
~# mkdir /opt/distr
5.	Подключиться с помощью WinSCP и скопировать файлы проекта в папку 
Копировать файлы проекта через WinSCP следует в папку /tmp. А затем из неё через Putty файлы копируются в папку назначения /opt/distr
~# cp -R /tmp/hyperledger /opt/distr/

V.	Установка Docker, Minikube, настройка сетевой файловой системы NFS

1.	Установить Docker
~# apt install curl gpg sudo git
~# install -m 0755 -d /etc/apt/keyrings
~# curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
~# chmod a+r /etc/apt/keyrings/docker.gpg
~# echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
~# apt update
~# apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

2.	Установка Minikube через универсальный пакетный менеджер ASDF
Клонировать репозиторий с последней версией в домашнюю папку пользователя
~# git clone https://github.com/asdf-vm/asdf.git .asdf 
Добавить переменные терминала пользователя, путь для запуска ASDF
~# nano /root/.bashrc
 export PATH=$PATH:$HOME/.asdf/bin
. "$HOME/.asdf/asdf.sh" 
Перезапустить терминал
Скачать репозиторий с Kubectl с помощью ASDF
~# asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git  
Установить последнюю версию Kubectl
~# asdf install kubectl latest
Скачать и установить Minikube
~# asdf plugin add minikube 
~# asdf install minikube latest
~# asdf global minikube latest
Это создаст кластер по умолчанию и локальный кластер kubernetes

В файле настроек версий добавить версию установленного kubectl
~# nano /root/.tool-versions
kubectl 1.32.0

VI.	Настройка сетевой файловой системы (NFS)

1.	Установить и настроить сервер сетевой файловой системы
Установить сервер
~# apt-get install nfs-kernel-server 
Активировать сервер сетевой файловой системы
~# systemctl enable --now nfs-server                                           
Создать папку для монтирования файловой системы
~# mkdir -p /mnt/nfs                                                           
Установить владельца папки, если планируется запуск от пользователя root
~# chown -R $USER:$USER /mnt/nfs                                               
Дать полные права на папку всем
~# chmod 777 /mnt/nfs/                                                        
Прописать данные в файле exports
~# nano /etc/exports
/mnt/nfs *(rw,sync,no_subtree_check,insecure)

Активировать NFS сервер
~# exportfs -arv
~# systemctl restart nfs-kernel-server

2.	Монтирование NFS диска на локальной системе
Создать локальную папку для монтирования в NFS
~# mkdir nfs_client                                                            
Смонтировать локальную папки в NFS
~# mount -o nolock -t nfs 127.0.0.1:/mnt/nfs /root/nfs_client                 
Для автоматического монтирования добавить в файл fstab точку монтирования
~# nano /etc/fstab                                                             
127.0.0.1:/mnt/nfs /root/nfs_client nfs auto,nofail,noatime,nolock,tcp,actimeo=1800 0 0

Перезапустить службу и перезапуститься
~# systemctl daemon-reload
~# reboot

Проверить что диск примонтировался
~# df -h 

Запустить Minikube проверить запущенные ноды
~# minikube start --driver=docker --force
~# kubectl get nodes
~# kubectl get events

VII.	Подготовка kubernetes

1.	Создать pv (persistent volume) для kubernetes используя NFS
Проверить в файле наименование папки монтирования и IP сервера NFS
~# nano /opt/distr/hyperledger/hf-on-k8s-course/1.nfs-config/pv.yaml 
nfs:
    path: /mnt/nfs/
    server: 10.0.2.5

Создать pv и проверить информацию о нем
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/1.nfs-config/pv.yaml
~# kubectl describe pv hf-on-k8s-course
 
2.	Создать pvc (persistent volume claim)
Создать pvc и проверить информацию о нем
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/1.nfs-config/pvc.yaml
~# kubectl describe pvc hf-on-k8s-course

3.	Конфигурация рабочей нагрузки POD
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/1.nfs-config/pod.yaml
~# kubectl describe pod hf-on-k8s-course-pv-pod

4.	Запуск и удаления тестового примера образа Nginx
~# kubectl apply -f https://k8s.io/examples/application/deployment.yaml
~# kubectl describe deployment nginx-deployment
Удаление контейнера nginx
~# kubectl delete deployment nginx-deployment

5.	Подготовка скриптов для развертывания блокчейна
Скопировать необходимые скрипты в папку NFS
~# cp -R /opt/distr/hyperledger/hlf-kubernetes/prerequsite/* nfs_client        
Сделать все скрипты исполняемыми и удалить права
~# chmod +x /mnt/nfs/scripts -R
~# ls -al /mnt/nfs/scripts/                                                    

VIII.	Конфигурация Organizations FabricCA

1.	Создать папку для базовой конфигурации
~# mkdir -p nfs_client/organizations
~# cp -r /opt/distr/hyperledger/hf_nfs_client/fabric-ca nfs_client/

2.	Развернуть FabricCA
Сбросить права на папку
~# chmod 777 -R /mnt/nfs/organizations
Применить развертывание
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/2.ca-config/org1/ca-org1.yaml
Применить сервис к развертыванию
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/2.ca-config/org1/ca-org1-service.yaml 
Повторить для остальных Org2 и Org3
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/2.ca-config/org2/ca-org2.yaml
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/2.ca-config/org2/ca-org2-service.yaml
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/2.ca-config/org3/ca-org3.yaml
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/2.ca-config/org3/ca-org3-service.yaml
Повторить для Orderer Org
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/2.ca-config/ordererOrg/ca-orderer.yaml
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/2.ca-config/ordererOrg/ca-orderer-service.yaml

Или перейти в папку с проектом и запустить скрипт для развертывания
~# cd /opt/distr/hyperledger/
~# bash deploy.all.ca.sh
~# cd /root

Запустить create-certs-job для создания сертификатов узлов
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/3.node-certificates-generation/create-certs-job.yaml
Запустить задание настройки канала, чтобы сгенерировать артефакты конфигурации канала
kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/4.channel-configuration-artifacts/channel-configuration-job.yaml

Проверить что все контейнеры запущены и работают, два последних контейнера должны быть в состоянии complete
~# kubectl get pods
 
IX.	Развертывание Orderers и Peers

1.	Развернуть orderers
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/5.orderer/orderer1
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/5.orderer/orderer2
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/5.orderer/orderer3
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/5.orderer/orderer4
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/5.orderer/orderer5

Каждая команда создает поды для одного из узлов orderer. Эти узлы выполняют роль службы упорядочивания транзакций, которые затем добавляются в блокчейн.

2.	Применить config map для внешних chaincode builders
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/6.configmap

Обновили  ConfigMap. Это необходимо для настройки связи узлов с кодом цепочки Сhaincode

3.	Развернуть Peers
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org1
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org2
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org3

Эти команды разворачивают поды для узлов peer организаций Org1, Org2 и Org3. Узлы peer хранят копии леджера и участвуют в обработке транзакций.

4.	Проверить, что все необходимые контейнеры запущены
~# kubectl get pods


X.	Установка и настройка Blockchain

1.	Создаем канал
~# kubectl exec -it -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org1/peer0Org1-cli.yaml -- bash /scripts/createAppChannel.sh

Этот скрипт создает канал “mychannel”  с использованием команды configtxgen и API Fabric. Блок используется для определения параметров канала.


2.	Подключение peers к каналу блокчейн – mychannel
~# kubectl exec -it -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org1/peer0Org1-cli.yaml -- peer channel join -b ./channel-artifacts/mychannel.block
~# kubectl exec -it -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org2/peer0Org2-cli.yaml -- peer channel join -b ./channel-artifacts/mychannel.block
~# kubectl exec -it -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org3/peer0Org3-cli.yaml -- peer channel join -b ./channel-artifacts/mychannel.block

Эти команды подключают узлы peer0 каждой организации к каналу mychannel, используя предварительно созданный блок канала.

3.	Настройка Anchor Peers
~# kubectl exec -it -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org1/peer0Org1-cli.yaml -- bash /scripts/updateAnchorPeer.sh Org1MSP  
~# kubectl exec -it -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org2/peer0Org2-cli.yaml -- bash /scripts/updateAnchorPeer.sh Org2MSP
~# kubectl exec -it -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org3/peer0Org3-cli.yaml -- bash /scripts/updateAnchorPeer.sh Org3MSP

Эти команды обновляют конфигурацию канала, чтобы назначить узлы peer0 каждой организации в качестве anchor peers. Anchor peers — это точки взаимодействия между разными организациями.

4.	Подготовка Lifecycle Chaincode
Копировать исходный код Chaincode на NFS
~# cp -R /opt/distr/hyperledger/hlf-kubernetes/8.chaincode/* nfs_client/chaincode/
~# bash /opt/distr/hyperledger/gen-external-package.sh basic org1 7052
~# bash /opt/distr/hyperledger/gen-external-package.sh basic org2 7052
~# bash /opt/distr/hyperledger/gen-external-package.sh basic org3 7052

Копирует исходный код всех chaincode на общий NFS-хранилище. Узлы будут обращаться к этому хранилищу для выполнения кода.

5.	Установить Lifecycle
Установить chaincode на каждый peer. После установки chaincode на каждый peer необходимо сохранить package identifier
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org1/peer0Org1-cli.yaml exec -- peer lifecycle chaincode install /opt/gopath/src/github.com/chaincode/basic/packaging/basic-org1.tgz
basic:9696f36db244c703a0e4039674ce3682f6743577d6f9ce536f82e7377700446f

~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org2/peer0Org2-cli.yaml exec -- peer lifecycle chaincode install /opt/gopath/src/github.com/chaincode/basic/packaging/basic-org2.tgz
basic:f3af4b71a80f622c90c82e1e80f28e282046d62821b47868dae0d961b8c40099

~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org3/peer0Org3-cli.yaml exec -- peer lifecycle chaincode install /opt/gopath/src/github.com/chaincode/basic/packaging/basic-org3.tgz
basic:457b9837645cc58e9941bdfcd807c70893e3fa36148af1f912c47c80cd8ef38b

6.	Установка цепочки жизненного цикла chaincode
Перейти в папку с файлом для сборки докер контейнера
~# cd nfs_client/chaincode/basic/

Собрать образ докера
~# docker build -t yangricardo/basic-cc-hlf:latest .

Загрузить образ в minikube
~# minikube image load yangricardo/basic-cc-hlf:latest –daemon

7.	Редактирование файлов развертывания chaincode
Для каждого файла -chaincode-deployment.yaml указать ранее сохраненный package identifier

~# nano /opt/distr/hyperledger/hf-on-k8s-course/9.cc-deploy/basic/org1/org1-chaincode-deployment.yaml
~# nano /opt/distr/hyperledger/hf-on-k8s-course/9.cc-deploy/basic/org2/org2-chaincode-deployment.yaml
~# nano /opt/distr/hyperledger/hf-on-k8s-course/9.cc-deploy/basic/org3/org3-chaincode-deployment.yaml

Вы открываете YAML-файлы для редактирования. В каждом файле указывается уникальный package identifier, который был сохранен при создании пакетов chaincode.

~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/9.cc-deploy/basic/org1
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/9.cc-deploy/basic/org2
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/9.cc-deploy/basic/org3

Команда kubectl apply создает поды с chaincode для каждой организации. Подтягиваются Docker-образы и запускаются контейнеры.

Проверить работу всех контейнеров
~# kubectl get pods

8.	Одобрение chaincode для организации.
Зайти в каждый контейнер peer0OrgX и выполнить команду approve. В команде необходимо указать ранее сохраненный package identifier
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org1/peer0Org1-cli.yaml exec -it -- bash

~# peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:9696f36db244c703a0e4039674ce3682f6743577d6f9ce536f82e7377700446f --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA

~# exit

~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org2/peer0Org2-cli.yaml exec -it -- bash

~# peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:f3af4b71a80f622c90c82e1e80f28e282046d62821b47868dae0d961b8c40099 --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA

~# exit

~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org3/peer0Org3-cli.yaml exec -it -- bash

~# peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:457b9837645cc58e9941bdfcd807c70893e3fa36148af1f912c47c80cd8ef38b --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA

~# exit

9.	Проверка готовности к регистрации.
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org3/peer0Org3-cli.yaml exec -it -- bash

~# peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name basic --version 1.0 --init-required --sequence 1 -o -orderer:7050 --tls --cafile $ORDERER_CA --output json

~# exit

10.	Процесс окончательной регистрации(фиксации).
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org3/peer0Org3-cli.yaml exec -it -- bash

Открывается интерактивная оболочка в CLI контейнере узла peer0 организации Org3. Это контейнер, через который отправляются команды для взаимодействия с Fabric.

~# peer lifecycle chaincode commit -o orderer:7050 --channelID mychannel --name basic --version 1.0 --sequence 1 --init-required --tls true --cafile $ORDERER_CA --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --peerAddresses peer0-org3:7051 --tlsRootCertFiles /organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt

~# exit

Завершаем процесс установки chaincode, регистрируя его как доступный для выполнения на канале mychannel
 -o orderer:7050: Адрес узла orderer для отправки транзакции.
--channelID mychannel: Канал, в котором регистрируется chaincode.
--name basic: Имя chaincode.
--version 1.0: Версия chaincode.
--sequence 1: Уникальная последовательность версии chaincode.
--init-required: Указывает, что chaincode требует инициализации.
--tls true: Включает TLS для соединения.
--cafile $ORDERER_CA: Указывает путь к TLS-сертификату orderer.
--peerAddresses: Указывает адреса узлов peer (Org1, Org2, Org3), участвующих в       транзакции.
--tlsRootCertFiles: Указывает TLS-сертификаты каждого peer.

11.	Проводим процесс инициализации.
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/7.peers/org3/peer0Org3-cli.yaml exec -it -- bash

Открываем оболочку в CLI контейнере узла peer0 организации Org3

~# peer chaincode invoke -o orderer:7050 --isInit --tls true --cafile $ORDERER_CA -C mychannel -n basic --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --peerAddresses peer0-org3:7051 --tlsRootCertFiles /organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt -c '{"Args":["InitLedger"]}' --waitForEvent

Транзакция, инициированная через invoke, фиксируется в блоке, который добавляется в цепочку блоков (блокчейн).

-o orderer:7050: Адрес узла orderer для отправки транзакции.
--isInit: Указывает, что это команда инициализации.
--tls true: Включает TLS для соединения.
--cafile $ORDERER_CA: Указывает TLS-сертификат для orderer.
-C mychannel: Канал, в котором выполняется chaincode.
-n basic: Имя chaincode.
--peerAddresses и --tlsRootCertFiles: Указывают адреса и сертификаты узлов peer.
-c '{"Args":["InitLedger"]}': Передает аргументы вызова, где InitLedger — функция chaincode.
--waitForEvent: Ожидает подтверждения выполнения события.

XI.	Установка API сервера

1.	Создать контейнер с сервером API
Перейти в папку с файлом Docker для создания контейнера
~# cd /opt/distr/hyperledger/hf-on-k8s-course/10.api/src/
Создать образ контейнера с сервером API
~# docker build -t yangricardo/hf-k8s-api:latest .
Импортировать образ в minikube
~# minikube image load yangricardo/hf-k8s-api:latest --daemon

2.	Запустить контейнер с API сервером в minikube
Перейти в папку со скриптом установки
~# cd /root/nfs_client/
Запустить скрипт для генерации профилей подключения
~# bash scripts/ccp.sh
Перезаписать конфигурацию по умолчанию FabricCA
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/10.api/k8/configmap.yaml apply
Запустить API сервер
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/10.api/k8/api.yaml apply
Дождаться запуска контейнера
~# kubectl get pods
Включить переадресацию порта 4000 на API, работает в фоном режиме
~# kubectl port-forward services/api 4000 &  
Убедиться, что minikube слушает порт 4000
~# lsof -i -P -n

XII.	Установка веб сервера и Hyperledger Explorer

1.	Установить веб сервер UI
Перейти в папку с Docker файлом для создания образа веб сервера
~# cd /opt/distr/hyperledger/hf-on-k8s-course/11.ui/
Создать образ
~# docker build -t yangricardo/hf-k8s-web:latest .
Импортировать образ в minikube
~# minikube image load yangricardo/hf-k8s-web:latest –daemon
Запустить контейнер
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/11.ui/frontend.yaml apply

2.	Установить сервер Hyperledger Explorer
Посмотреть и скопировать ключ администратора для подключения к блокчейн
~# ls -al /mnt/nfs/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/keystore/
Вставить ключ в файл configmap.yaml
~# nano /opt/distr/hyperledger/hf-on-k8s-course/12.explorer/configmap.yaml
Конфигурация и запуск контейнера Hyperledger Explorer
~# kubectl apply -f /opt/distr/hyperledger/hf-on-k8s-course/12.explorer/configmap.yaml
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/12.explorer/explorer.yaml apply
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/12.explorer/explorerdb.yaml apply
~# kubectl -f /opt/distr/hyperledger/hf-on-k8s-course/12.explorer/explorer.yaml apply
Включить переадресацию порта 8080 на сервер, работает в фоном режиме
~# kubectl port-forward services/explorer 8080 --address='0.0.0.0' &
Для подключения к веб интерфейсу необходимо открыть веб браузер и перейти по адресу 127.0.0.1:8080


