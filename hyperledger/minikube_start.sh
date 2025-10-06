#!/bin/bash

# Инициализация asdf
. $HOME/.asdf/asdf.sh

# Проверка доступности minikube
if ! command -v minikube >/dev/null 2>&1; then
    echo "Ошибка: minikube не найден"
    exit 1
fi

# Проверка доступности kubectl
if ! command -v kubectl >/dev/null 2>&1; then
    echo "Ошибка: kubectl не найден"
    exit 1
fi

# Запуск Minikube с драйвером Docker
minikube start --driver=docker --force || { echo "Ошибка запуска Minikube"; exit 1; }

# Включение dashboard
minikube addons enable dashboard || { echo "Ошибка включения dashboard"; exit 1; }

# Ожидание готовности dashboard
echo "Ожидание готовности dashboard..."
kubectl wait --for=condition=available deployment/kubernetes-dashboard -n kubernetes-dashboard --timeout=220s || { echo "Dashboard не запустился"; exit 1; }

sleep 60
# Прокидывание порта для dashboard (порт 8080 на хосте, 80 в сервисе)
echo "Запуск port-forward..."
kubectl port-forward -n kubernetes-dashboard svc/kubernetes-dashboard 8080:80 --address=0.0.0.0 &
DASHBOARD_PID=$!

sleep 15
kubectl port-forward services/api 4000:4000 --address=0.0.0.0 &
API_PID=$!

sleep 15
kubectl port-forward services/explorer 8081:8080 --address=0.0.0.0 &
EXPLORER_PID=$!

# Сохраняем PID процесса port-forward
echo "Dashboard port-forward PID: $DASHBOARD_PID"
echo "API port-forward PID: $API_PID"
echo "Explorer port-forward PID: $EXPLORER_PID"

# Ждём, пока процесс port-forward работает
wait $DASHBOARD_PID $API_PID $EXPLORER_PID
