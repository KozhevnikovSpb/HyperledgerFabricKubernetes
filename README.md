I.	Установка и настройка виртуальной машины.

1.	Необходимо установить и настроить подходящую систему виртуализации (Virtual Box, VMware Workstation, Proxmox, Hyper-V и др.) В данной инструкции будет использована система для виртуализации Oracle VM VirtualBox. Скачать можно по ссылке - https://www.virtualbox.org/wiki/Downloads

2.	Создать виртуальную сеть NAT со следующими параметрами
<img width="620" height="255" alt="image" src="https://github.com/user-attachments/assets/f5be5666-0c9f-4e42-bb18-5914d2155c42" />
<img width="188" height="71" alt="image" src="https://github.com/user-attachments/assets/cd982097-0860-46c2-b5e2-91bdf144db54" />
<img width="94" height="110" alt="image" src="https://github.com/user-attachments/assets/cdf4b32e-4bbe-4a74-a6bd-d5d97334a4b7" />
<img width="964" height="637" alt="image" src="https://github.com/user-attachments/assets/0f59469d-fe62-448e-b384-e156a3a9457a" />

3.	Создать перенаправление портов 
<img width="1144" height="236" alt="image" src="https://github.com/user-attachments/assets/223c3ec8-4861-412b-b6aa-7634dbb2d939" />

4.	Создаем виртуальную машину со следующими минимальными параметрами:
  - Оперативная память от 8 Gb;
  -	Процессор от 6-ти ядер;
  -	Жесткий диск от 45 Gb;
  -	Сетевой интерфейс в режим NAT Сеть.
<img width="377" height="126" alt="image" src="https://github.com/user-attachments/assets/3f0453ef-f793-4e41-8ffe-5445a981c66e" />
<img width="548" height="309" alt="image" src="https://github.com/user-attachments/assets/e9760a10-1005-4184-8497-d526b20ac577" />
<img width="544" height="174" alt="image" src="https://github.com/user-attachments/assets/b6b0e496-5925-4238-b8ed-67c9bc37c31b" />
<img width="542" height="253" alt="image" src="https://github.com/user-attachments/assets/b8df4efa-b304-488b-8e34-438bbd5f42af" />
<img width="547" height="292" alt="image" src="https://github.com/user-attachments/assets/d31a72e4-7221-419b-8541-981c9c528499" />
<img width="966" height="499" alt="image" src="https://github.com/user-attachments/assets/c4ae8936-13e0-4819-8d16-39ff00ee67fa" />

5.	В качестве гостевой ОС можно использовать Ubuntu Server (желательно в самом минимальном режиме) или Debian (без дальнейшей установки GUI). При установке Ubuntu Server необходимо обратить внимание на выбор типа жесткого диска в процессе установки, он не должен иметь тип LVM. При использовании ОС Debian получается минимальный установочный размер ОС около 2 Gb, это меньше чем для ОС Ubuntu Server. 


II.	Установка ОС Debian на виртуальную машину

1.	После создания виртуальной машины нажимаем «Старт» и начинаем устанавливать гостевую ОС: 
<img width="255" height="101" alt="image" src="https://github.com/user-attachments/assets/b8f35e28-c880-47a3-a1c2-21d16f6d8fcd" />

  -	На экране приветствия выбираем – Graphical install
  -	Язык оставляем – English
  -	Локацию можно установить – Other -> Europe -> Russian Federation
  -	Конфигурацию локали оставляем и язык клавиатуры оставляем по умолчанию
  -	На этапе задания Domain name, необходимо вернуться на шаг назад и сконфигурировать IP адрес вручную
      - ip – 10.0.2.5
      - netmask – 255.255.255.0
      - gateway – 10.0.2.1
      - nameserver – 10.0.2.1
<img width="277" height="184" alt="image" src="https://github.com/user-attachments/assets/a9bf30f4-2544-4470-b5e4-6cb44f7b38dd" />

  -	Hostname и Domain name можно указать любой по желанию
  -	Задаем пароль root, затем имя администратор и пароль для него
  -	Выбираем часовой пояс
  -	При разметке жесткого диска оставляем все по умолчанию – Guided – use entire disk
  -	При настройке partition disks – All files in one partition
  -	На заключительном этапе – соглашаемся с записью изменений на диск
  -	Отказываемся от сканирования других медиа
  -	Выбираем для настройки package manager все по умолчанию
  -	При завершении установки оставляем в опциях только – SSH server и Standard system utilities
    Обращаю внимание, если используется Ubuntu, то Docker нельзя ставить из прилагаемого списка в конце установки.
  -	В конце установки соглашаемся с установкой grub и устанавливаем его в корень /dev/sda
<img width="287" height="390" alt="image" src="https://github.com/user-attachments/assets/d0da6359-231a-4e5e-ac3a-efbdc5c8ab0c" />


III.	Putty и WinCSP

1.	Для работы с виртуальной машины необходимо скачать и установить:
  •	Putty - https://www.putty.org/
  •	WinCSP - https://winscp.net/eng/download.php

2.	Подключаться к виртуальной машине следует через адрес локальной петли 127.0.0.1
<img width="323" height="317" alt="image" src="https://github.com/user-attachments/assets/b1af38bb-9859-4b66-918e-720b29d9c7d8" />
<img width="465" height="317" alt="image" src="https://github.com/user-attachments/assets/d9b26732-6844-4972-8b09-231fef61df29" />
<img width="341" height="225" alt="image" src="https://github.com/user-attachments/assets/20e37895-a82c-468b-a848-ecd8f8b178fa" />
<img width="200" height="54" alt="image" src="https://github.com/user-attachments/assets/d8eecf18-fc68-4ed8-af77-4b4543229421" />


IV.	Предварительная настройка виртуальной машины

1.	После подключения необходимо поднять права до root (следует делать при каждом подключении):
~# su –
Ввести пароль от root (должен быть задан на этапе установки ОС)

2.	Отключить протокол IPv6
Открыть файл grub найти строку, в которой есть запись "GRUB_CMDLINE_LINUX", и отредактировать её
~# nano /etc/default/grub
GRUB_CMDLINE_LINUX=”ipv6.disable=1”
<img width="852" height="189" alt="image" src="https://github.com/user-attachments/assets/c0dc78bc-3d07-4c79-8376-1c3254bddae2" />

Закрыть файл с сохранением настроек ctrl+x, y + enter
Запустить обновление grub
~# update-grub2

3.	Отключить swap 
~# swapoff -a
Отключить swap
Открыть файл fstab, закомментировать строчку подключения swap, перезапустить ОС
~# nano /etc/fstab
~# reboot
<img width="933" height="43" alt="image" src="https://github.com/user-attachments/assets/7f13b911-7111-404d-868e-8ccaf9d3a47d" />

После перезагрузки перезапускаем сессию Putty, заново авторизуемся и поднимаем свои права до root
Проверить статус swap
~# systemctl --type swap
<img width="974" height="159" alt="image" src="https://github.com/user-attachments/assets/eac108ee-5483-4075-919e-d3876188bb77" />

4.	Создать папку для хранения исходных файлов проекта
~# mkdir /opt/distr

5.	Подключиться с помощью WinSCP и скопировать файлы проекта в папку 
Копировать файлы проекта через WinSCP следует в папку /tmp. А затем из неё через Putty файлы копируются в папку назначения /opt/distr
~# cp -R /tmp/hyperledger /opt/distr/
<img width="192" height="186" alt="image" src="https://github.com/user-attachments/assets/f9ac61a5-384a-4187-9c50-6e949acff4e3" />


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
<img width="436" height="100" alt="image" src="https://github.com/user-attachments/assets/b4e1099e-84f9-4bc2-9e82-b24155e79086" />

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
kubectl 1.32.1
<img width="208" height="110" alt="image" src="https://github.com/user-attachments/assets/5cd08d7c-579d-4b65-affd-3078c7d9c889" />


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
<img width="642" height="103" alt="image" src="https://github.com/user-attachments/assets/17ec1879-9ed9-4806-b3cd-3b43ff87e2c2" />

Активировать NFS сервер
~# exportfs -arv
~# systemctl restart nfs-kernel-server

2.	Монтирование NFS диска на локальной системе
Создать локальную папку для монтирования в NFS
~# mkdir nfs_client  
~# chown -R nobody:nogroup /mnt/nfs_share/
~# sudo chmod 777 /mnt/nfs_share/                                                          
Смонтировать локальную папки в NFS
~# mount -o nolock -t nfs 127.0.0.1:/mnt/nfs /root/nfs_client                 
Для автоматического монтирования добавить в файл fstab точку монтирования
~# nano /etc/fstab                                                             
127.0.0.1:/mnt/nfs /root/nfs_client nfs auto,nofail,noatime,nolock,tcp,actimeo=1800 0 0
<img width="928" height="162" alt="image" src="https://github.com/user-attachments/assets/0d3a0907-2c12-43b0-a083-018c991bfeab" />

Перезапустить службу и перезапуститься
~# systemctl daemon-reload
~# reboot
Проверить что диск примонтировался
~# df -h 
<img width="888" height="308" alt="image" src="https://github.com/user-attachments/assets/ae6bca60-8c69-4c4b-8e72-fb0cba299363" />

Запустить Minikube проверить запущенные ноды
~# minikube start --driver=docker --force
~# kubectl get nodes
~# kubectl get events
<img width="975" height="668" alt="image" src="https://github.com/user-attachments/assets/66942af7-5e65-4c3c-be29-51157e64590a" />


VII.	Подготовка kubernetes

1.	Создать pv (persistent volume) для kubernetes используя NFS
Проверить в файле наименование папки монтирования и IP сервера NFS
~# nano /opt/distr/hyperledger/kubernetes/1.nfs/pv.yaml
nfs:
    path: /mnt/nfs/
    server: 10.0.2.5
Создать pv и проверить информацию о нем
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/1.nfs/pv.yaml
~# kubectl describe pv mypv
<img width="957" height="528" alt="image" src="https://github.com/user-attachments/assets/42337aac-9405-4eda-a171-3d0b662faf94" />

2.	Создать pvc (persistent volume claim)
Создать pvc и проверить информацию о нем
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/1.nfs/pvc.yaml
~# kubectl describe pvc mypvc
<img width="974" height="419" alt="image" src="https://github.com/user-attachments/assets/999cb303-0b3c-4909-b3bd-810f3dbf5228" />

3.	Конфигурация рабочей нагрузки POD
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/1.nfs/pod.yaml
~# kubectl describe pod task-pv-pod
<img width="936" height="288" alt="image" src="https://github.com/user-attachments/assets/c9450d68-4b25-4f1c-a975-5c40f081cda3" />

4.	Запуск и удаления тестового примера образа Nginx
~# kubectl apply -f https://k8s.io/examples/application/deployment.yaml
~# kubectl describe deployment nginx-deployment
Удаление контейнера nginx
~# kubectl delete deployment nginx-deployment
<img width="975" height="433" alt="image" src="https://github.com/user-attachments/assets/fec88def-7a6a-4a48-a4f0-2de4885b4be8" />

5.	Подготовка скриптов для развертывания блокчейна
Скопировать необходимые скрипты в папку NFS
~# cp -R /opt/distr/hyperledger/kubernetes/prerequsite/scripts nfs_client
Сделать все скрипты исполняемыми и удалить права
~# chmod +x /mnt/nfs/scripts -R
~# ls -al /mnt/nfs/scripts/                                                    
<img width="758" height="305" alt="image" src="https://github.com/user-attachments/assets/54d31e75-65b1-4d9a-b5ab-c0f23a1fc466" />


VIII.	Конфигурация Organizations FabricCA

1.	Создать папку для базовой конфигурации
~# mkdir -p nfs_client/organizations
cp -R /opt/distr/hyperledger/kubernetes/prerequsite/* ./nfs_client/

2.	Развернуть FabricCA
Сбросить права на папку
~# chmod 777 -R /mnt/nfs/organizations
Применить развертывание
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/
kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/ca-org1.yaml
Применить сервис к развертыванию
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/ca-org1-service.yaml 
Повторить для остальных Org2 и Org3
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/ca-org2.yaml 
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/ca-org2-service.yaml
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/ca-org3.yaml
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/ca-org3-service.yaml
Повторить для Orderer Org
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/ca-orderer.yaml
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/2.ca/ca-orderer-service.yaml
Или перейти в папку с проектом и запустить скрипт для развертывания
~# cd /opt/distr/hyperledger/
~# bash deploy.all.ca.sh
~# cd /root
Запустить create-certs-job для создания сертификатов узлов
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/3.certifcates/job-cert.yaml
Запустить задание настройки канала, чтобы сгенерировать артефакты конфигурации канала
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/4.artifacts/job-art.yaml
Проверить что все контейнеры запущены и работают, два последних контейнера должны быть в состоянии complete
~# kubectl get pods
<img width="807" height="221" alt="image" src="https://github.com/user-attachments/assets/d9b2e03c-9547-493d-a004-8fda60c5ade7" />

 
IX.	Развертывание Orderers и Peers
<img width="974" height="468" alt="image" src="https://github.com/user-attachments/assets/af210bd8-0f76-42df-83ea-d6106395b4d9" />

1.	Развернуть orderers

2.	chmod -R 777 /mnt/nfs/{organizations,system-genesis-block}
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/5.orderer
Каждая команда создает поды для одного из узлов orderer. Эти узлы выполняют роль службы упорядочивания транзакций, которые затем добавляются в блокчейн.

3.	Применить config map для внешних chaincode builders
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/6.configmap
Обновили  ConfigMap. Это необходимо для настройки связи узлов с кодом цепочки Сhaincode

4.	Развернуть Peers
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/7.peers/org1
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/7.peers/org2
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/7.peers/org3
Эти команды разворачивают поды для узлов peer организаций Org1, Org2 и Org3. Узлы peer хранят копии леджера и участвуют в обработке транзакций.

5.	Проверить, что все необходимые контейнеры запущены
~# kubectl get pods
<img width="943" height="504" alt="image" src="https://github.com/user-attachments/assets/398bdc43-d9f3-4f31-bd7c-7aba6c7e6934" />


X.	Установка и настройка Blockchain

1.	Создаем канал
~# kubectl exec -it -f /opt/distr/hyperledger/kubernetes/7.peers/org1/peer0Org1-cli.yaml -- bash /scripts/createAppChannel.sh
Этот скрипт создает канал “mychannel”  с использованием команды configtxgen и API Fabric. Блок используется для определения параметров канала.
<img width="889" height="468" alt="image" src="https://github.com/user-attachments/assets/aebe9cf4-c482-4b1c-a98a-3fcb6633e24f" />

2.	Подключение peers к каналу блокчейн – mychannel
~# kubectl exec -it -f /opt/distr/hyperledger/kubernetes/7.peers/org1/peer0Org1-cli.yaml -- peer channel join -b ./channel-artifacts/mychannel.block
~# kubectl exec -it -f /opt/distr/hyperledger/kubernetes/7.peers/org2/peer0Org2-cli.yaml -- peer channel join -b ./channel-artifacts/mychannel.block
~# kubectl exec -it -f /opt/distr/hyperledger/kubernetes/7.peers/org3/peer0Org3-cli.yaml -- peer channel join -b ./channel-artifacts/mychannel.block
Эти команды подключают узлы peer0 каждой организации к каналу mychannel, используя предварительно созданный блок канала.

3.	Настройка Anchor Peers
~# kubectl exec -it -f /opt/distr/hyperledger/kubernetes/7.peers/org1/peer0Org1-cli.yaml -- bash /scripts/updateAnchorPeer.sh Org1MSP
~# kubectl exec -it -f /opt/distr/hyperledger/kubernetes/7.peers/org2/peer0Org2-cli.yaml -- bash /scripts/updateAnchorPeer.sh Org2MSP
~# kubectl exec -it -f /opt/distr/hyperledger/kubernetes/7.peers/org3/peer0Org3-cli.yaml -- bash /scripts/updateAnchorPeer.sh Org3MSP
Эти команды обновляют конфигурацию канала, чтобы назначить узлы peer0 каждой организации в качестве anchor peers. Anchor peers — это точки взаимодействия между разными организациями.

4.	Подготовка Lifecycle Chaincode
Копировать исходный код Chaincode на NFS
~# cp -R /opt/distr/hyperledger/kubernetes/8.chaincode/* nfs_client/chaincode/
~# bash /opt/distr/hyperledger/kubernetes/gen-external-package.sh basic org1 7052
~# bash /opt/distr/hyperledger/kubernetes/gen-external-package.sh basic org2 7052
~# bash /opt/distr/hyperledger/kubernetes/gen-external-package.sh basic org3 7052
Копирует исходный код всех chaincode на общий NFS-хранилище. Узлы будут обращаться к этому хранилищу для выполнения кода.

5.	Установить Lifecycle
Установить chaincode на каждый peer. После установки chaincode на каждый peer необходимо сохранить package identifier
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org1/peer0Org1-cli.yaml exec -- peer lifecycle chaincode install /opt/gopath/src/github.com/chaincode/basic/packaging/basic-org1.tgz
<img width="887" height="61" alt="image" src="https://github.com/user-attachments/assets/81b6e3ee-1968-47aa-9789-4dd22abe0f5a" />

basic:9696f36db244c703a0e4039674ce3682f6743577d6f9ce536f82e7377700446f
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org2/peer0Org2-cli.yaml exec -- peer lifecycle chaincode install /opt/gopath/src/github.com/chaincode/basic/packaging/basic-org2.tgz
<img width="934" height="67" alt="image" src="https://github.com/user-attachments/assets/d28f8895-5f05-40bc-97e9-b9766350d314" />

basic:f3af4b71a80f622c90c82e1e80f28e282046d62821b47868dae0d961b8c40099
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org3/peer0Org3-cli.yaml exec -- peer lifecycle chaincode install /opt/gopath/src/github.com/chaincode/basic/packaging/basic-org3.tgz
<img width="880" height="73" alt="image" src="https://github.com/user-attachments/assets/071d6c68-b739-4b92-8f41-903e2f0a2144" />

basic:457b9837645cc58e9941bdfcd807c70893e3fa36148af1f912c47c80cd8ef38b

6.	Lifecycle chaincode install
Перейти в папку с файлом для сборки докер контейнера
~# cd nfs_client/chaincode/basic/
Собрать образ докера
~# docker build -t yangricardo/basic-cc-hlf:latest .
Загрузить образ в minikube
~# minikube image load yangricardo/basic-cc-hlf:latest --daemon

7.	Редактирование файлов развертывания chaincode
Для каждого файла -chaincode-deployment.yaml указать ранее сохраненный package identifier
<img width="887" height="82" alt="image" src="https://github.com/user-attachments/assets/69635220-751a-4d55-92e2-f59d1c2ce1ef" />

~# nano /opt/distr/hyperledger/kubernetes/9.cc-deploy/basic/org1/org1-chaincode-deployment.yaml
~# nano /opt/distr/hyperledger/kubernetes/9.cc-deploy/basic/org2/org2-chaincode-deployment.yaml
~# nano /opt/distr/hyperledger/kubernetes/9.cc-deploy/basic/org3/org3-chaincode-deployment.yaml
Вы открываете YAML-файлы для редактирования. В каждом файле указывается уникальный package identifier, который был сохранен при создании пакетов chaincode.
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/9.cc-deploy/basic
Команда kubectl apply создает поды с chaincode для каждой организации. Подтягиваются Docker-образы и запускаются контейнеры.
Проверить работу всех контейнеров
~# kubectl get pods
<img width="905" height="532" alt="image" src="https://github.com/user-attachments/assets/45a4c354-5f50-4839-ada6-eb5741d6efd8" />

8.	Approve Chaincode for org
Зайти в каждый контейнер peer0OrgX и выполнить команду approve. В команде необходимо указать ранее сохраненный package identifier
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org1/peer0Org1-cli.yaml exec -it -- bash
~# peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:e77ac427e13632e821fdbb9da9e276bc96650d4f34b88b2c4172a8d072667278 --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA
~# exit
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org2/peer0Org2-cli.yaml exec -it -- bash
~# peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:fb32d989abb75dc2c431aa1f0dfea5c342f01a6f5090be3c085c8b9b11b79f36 --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA
~# exit
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org3/peer0Org3-cli.yaml exec -it -- bash
~# peer lifecycle chaincode approveformyorg --channelID mychannel --name basic --version 1.0 --init-required --package-id basic:457b9837645cc58e9941bdfcd807c70893e3fa36148af1f912c47c80cd8ef38b --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA
~# exit

9.	Check commit readiness
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org1/peer0Org1-cli.yaml exec -it -- bash
~# peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name basic --version 1.0 --init-required --sequence 1 -o -orderer:7050 --tls --cafile $ORDERER_CA --output json
<img width="273" height="118" alt="image" src="https://github.com/user-attachments/assets/5cebd6ad-dcb0-493e-b08f-1f188256b179" />

~# exit

10.	Commit chaincode definition
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org1/peer0Org1-cli.yaml exec -it -- bash
Открывается интерактивная оболочка в CLI контейнере узла peer0 организации Org3. Это контейнер, через который отправляются команды для взаимодействия с Fabric.
~# peer lifecycle chaincode commit -o orderer:7050 --channelID mychannel --name basic --version 1.0 --sequence 1 --init-required --tls true --cafile $ORDERER_CA --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --peerAddresses peer0-org3:7051 --tlsRootCertFiles /organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
<img width="528" height="92" alt="image" src="https://github.com/user-attachments/assets/b4e70c60-128b-4e96-8f59-e07ad982ac3b" />

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

11.	Commit chaincode definition
~# kubectl -f /opt/distr/hyperledger/kubernetes/7.peers/org1/peer0Org1-cli.yaml exec -it -- bash
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
~# cd /opt/distr/hyperledger/kubernetes/10.api/src/
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
~# kubectl -f /opt/distr/hyperledger/kubernetes/10.api/k8/configmap.yaml apply
Запустить API сервер
~# kubectl -f /opt/distr/hyperledger/kubernetes/10.api/k8/api.yaml apply
Дождаться запуска контейнера
~# kubectl get pods
<img width="974" height="75" alt="image" src="https://github.com/user-attachments/assets/a2b2ff04-8545-49c9-8fe5-b6c9b28707a8" />

Включить переадресацию порта 4000 на API, работает в фоном режиме
~# kubectl port-forward services/api 4000 &  
Убедиться, что minikube слушает порт 4000
~# lsof -i -P -n
<img width="974" height="53" alt="image" src="https://github.com/user-attachments/assets/8d4f698c-3ab3-456c-88aa-5b9f300e4c5a" />


XII.	Установка веб сервера и Hyperledger Explorer

1.	Установить веб сервер UI
Перейти в папку с Docker файлом для создания образа веб сервера
~# cd /opt/distr/hyperledger/kubernetes/11.ui/
Создать образ
~# docker build -t yangricardo/hf-k8s-web:latest .
Импортировать образ в minikube
~# minikube image load yangricardo/hf-k8s-web:latest --daemon
Запустить контейнер
~# kubectl -f /opt/distr/hyperledger/kubernetes/11.ui/frontend.yaml apply

2.	Установить сервер Hyperledger Explorer
Посмотреть и скопировать ключ администратора для подключения к блокчейн
~# ls -al /mnt/nfs/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/keystore/
<img width="974" height="106" alt="image" src="https://github.com/user-attachments/assets/45b60c99-9f62-4dea-b496-1a37b3835a4d" />

Вставить ключ в файл configmap.yaml
~# nano /opt/distr/hyperledger/kubernetes/12.explorer/configmap.yaml
<img width="1076" height="80" alt="image" src="https://github.com/user-attachments/assets/7a7f7c3e-fd86-499d-b544-a95ae5bb9957" />

Конфигурация и запуск контейнера Hyperledger Explorer
~# kubectl apply -f /opt/distr/hyperledger/kubernetes/12.explorer/configmap.yaml
~# kubectl -f /opt/distr/hyperledger/kubernetes/12.explorer/explorerdb.yaml apply
~# kubectl -f /opt/distr/hyperledger/kubernetes/12.explorer/explorer.yaml apply
Включить переадресацию порта 8080 на сервер, работает в фоном режиме
~# kubectl port-forward services/explorer 8080 --address='0.0.0.0' &
Для подключения к веб интерфейсу необходимо открыть веб браузер и перейти по адресу 127.0.0.1:8080
<img width="613" height="328" alt="image" src="https://github.com/user-attachments/assets/01476cc5-39f5-497b-aea4-eb36b4032220" />


XIII.	Запуск образа

Образ состоит из установленной ОС Debian 12. На ней запускается Kubernetes с использование эмулятора Minikube. Minikube позволяет развернуть и использовать Kubernetes в рамках одноузлового кластера, что удобно при обучении, разработке или тестировании. Нет необходимости разворачивать полноценный кластер состоящий минимум из трех серверов.
В состав кластера входят следующие ноды

Запуск:
После старта виртуальной машины, необходимо запустить Minikube и в течении 5 – 10 минут дождаться запуска всех подов. 
1.	Заходим в виртуальную машину логин – root, пароль – 123456
<img width="508" height="180" alt="image" src="https://github.com/user-attachments/assets/5cf0b57b-77fc-4d80-ba67-01285ed529d6" />
 
2.	Запускаем Minikube командой – minikube start –drive=docker –force
<img width="1058" height="479" alt="image" src="https://github.com/user-attachments/assets/322d18a4-3e76-49d9-9cae-026a0c9b3396" />
   
3.	Ждем 5–10 минут и проверяем поды командой – kubectl get pods
