#!/bin/bash
if [[ -n $IP ]]
then
/chainweb/chainweb-node --p2p-hostname $IP
else
echo ip адрес не найден!
echo Укажите во вкладке UPDATE выданный провайдером IP адрес указанный во вкладке lease и обновите деплоймент!
echo Пример:
echo ==================================
echo services:               
echo ---node:
echo -----image: kadena/chainweb-node
echo ------env:
echo ------ - "IP=123.123.123.123"
echo ==================================
sleep infinity
fi
