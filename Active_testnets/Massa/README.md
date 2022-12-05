# Massa Node on Akash Network
# Нода Massa для развертки на Akash Network 
<div align="center">

![pba](https://user-images.githubusercontent.com/23629420/163564929-166f6a01-a6e2-4412-a4e9-40e54c821f05.png)
| [Akash Network](https://akash.network/) | [Forum Akash Network](https://forum.akash.network/) | 
|:--:|:--:|
___
Before you start - subscribe to our news channels: 

Прежде чем начать - подпишитесь на наши новостные каналы:

| [Discord Akash](https://discord.gg/3SNdg3BS) | [Telegram Akash EN](https://t.me/AkashNW) | [Telegram Akash RU](https://t.me/akash_ru) | [TwitterAkash](https://twitter.com/akashnet_) | [TwitterAkashRU](https://twitter.com/akash_ru) |
|:--:|:--:|:--:|:--:|:--:|

</div>

<div align="center">
  
[English version](https://github.com/Dimokus88/Massa/blob/main/README.md#massa-node-for-deployment-on-akash-network) | [Русская версия](https://github.com/Dimokus88/Massa/blob/main/README.md#%D0%BD%D0%BE%D0%B4%D0%B0-%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B0-massa-%D0%B4%D0%BB%D1%8F-%D1%80%D0%B0%D0%B7%D0%B2%D0%B5%D1%80%D1%82%D0%BA%D0%B8-%D0%BD%D0%B0-akash-network)
  
  
</div>

Thanks for help with assembly [Andy](https://twitter.com/andy31259) !
___

Отдельная благодарность за помощь в сборке [Andy](https://twitter.com/andy31259) !
___

### Massa node for deployment on Akash Network

* If you already have a wallet - go to paragraph ["Request tokens in a faucet"](https://github.com/Dimokus88/Massa/blob/main/README.md#request-tokens-in-a-faucet).

## Create wallet
* Go to https://massa.net/testnet/wallet and generate a wallet by clicking "Generate" (save the private key from the "Add"). Click "Add".
 
![Alt-текст](https://user-images.githubusercontent.com/23629420/167258193-4b7ed05b-f580-4e0d-adad-b25f407734f6.png)

## Deploy Massa node on Akash Network

* Open ***Akashlytics***,if you don't have it installed, then [link for download](https://www.akashlytics.com/deploy).

* We check the presence of a balance  ***(>5АКТ)*** and the presence of an installed certificate.

![image](https://user-images.githubusercontent.com/23629420/165339432-6f053e43-4fa2-4429-8eb7-d2fc66f47c70.png)

* Enter info to [deploy.yml](https://github.com/Dimokus88/Massa/blob/main/deploy.yml) from the your wallet and Discord ID (get in MassaBot), and don't forget to uncomment the lines (remove the # symbol at the beginning of the lines).

![image](https://user-images.githubusercontent.com/23629420/172821020-b551d49a-5b03-4813-bcd5-a3e5a634bbe8.png)

* Create deployment and waiting of the bids, select provider and waiting start deployment your container.

![Alt-текст](https://user-images.githubusercontent.com/23629420/163015058-d2d07eff-2eb5-4cad-9e17-526ca4219f1c.png)

*Go to Logs. Deploing of node takes about of ***5 minutes***. Then,go to window logs, get information about the work massa-client. The hash of the transaction that needs to be submitted to MassaBot (Discord) to register for the rewards program will be displayed in ***last line***.


![Alt-текст](https://user-images.githubusercontent.com/23629420/163021720-7b7a7779-eb68-440a-93a0-6effa37f29d8.png)

The public address ***Public key*** will also be displayed, which must be sent to the ***Discord*** branch to receive test tokens (***see below***).

![image](https://user-images.githubusercontent.com/23629420/172821287-6ab6d57b-e910-4800-b224-9430622b61c8.png)

## Request tokens in a faucet

Go to  [Discord Massa](https://discord.gg/W5X3frEE), channel ```#testnet-faucet```  and request in faucet tokens to your public adrress. Wait for the receipt of tokens on the account and proceed to the next item (check balancein [blockchain explorer Massa](https://massa.net/testnet) by entering your public address).

* And you can download logs in file, click "Download logs".

* If you see such errors, then your node has not connected yet, give it some time.

![image](https://user-images.githubusercontent.com/23629420/172899308-6adbec68-b819-4103-860b-892b2b8885ff.png)


### Thank you for choosing Akash Network!
___

# Нода проекта Massa для развертки на Akash Network

* Если у вас уже есть кошелек - переходите к пункту ["Запрос токенов в кране"](https://github.com/Dimokus88/Massa/blob/main/README.md#%D0%B7%D0%B0%D0%BF%D1%80%D0%BE%D1%81-%D1%82%D0%BE%D0%BA%D0%B5%D0%BD%D0%BE%D0%B2-%D0%B2-%D0%BA%D1%80%D0%B0%D0%BD%D0%B5).

## Создание кошелька
* Идем по адресу https://massa.net/testnet/wallet и генерируем кошелек нажимая Generate (сохраняем приватный ключ из поля Add). Нажимаем кнопку Add.
 
![Alt-текст](https://user-images.githubusercontent.com/23629420/167258193-4b7ed05b-f580-4e0d-adad-b25f407734f6.png)

## Разворачиваем ноду с помощью маркетплейса Akash Network

* Открываем ```Akashlytics```, если он у вас не установлен - то вот [ссылка на скачивание](https://www.akashlytics.com/deploy).

* Проверяем наличие баланса (>5АКТ) и наличие установленного сертификата.

![image](https://user-images.githubusercontent.com/23629420/165339432-6f053e43-4fa2-4429-8eb7-d2fc66f47c70.png)

* Заполняем [deploy.yml](https://github.com/Dimokus88/Massa/blob/main/deploy.yml) со своими данными кошелька и Discord ID (получить у MassaBot), а также незабудьте расскомментить строки (удалить символ # в начале строк).

![image](https://user-images.githubusercontent.com/23629420/172821043-fd5d3011-5397-4b83-b25d-caa76b0ccd0b.png)

* Создаем deployment и должидаемся предложений, выбираем провайдера и ждем начала развертывания контейнера.

![Alt-текст](https://user-images.githubusercontent.com/23629420/163015058-d2d07eff-2eb5-4cad-9e17-526ca4219f1c.png)

* Переходим в вкладку Logs. Разверка ноды занимает около ***5 минут***. Через 5 минут в окно лога начнет выводится информация о работе в massa-client. Хеш транзакции, которую надо предоставить MassaBot в Discord для регистрации в программе вознаграждений, будет выведен ***последней строкой***. 

![Alt-текст](https://user-images.githubusercontent.com/23629420/163021720-7b7a7779-eb68-440a-93a0-6effa37f29d8.png)

* Так же будет отображен публичный адрес ***Public key*** , который нужно отправить в ветку ***Discord*** для получения тестовых токенов (***см. далее***). 

![image](https://user-images.githubusercontent.com/23629420/172821287-6ab6d57b-e910-4800-b224-9430622b61c8.png)

## Запрос токенов в кране

Идем в  [дискорд Massa](https://discord.gg/W5X3frEE), канал ```#testnet-faucet```  и запрашиваем в кране токены на полученны адрес. Баланс можно проверить в [обозревателе блокчейна](https://massa.net/testnet) введя свой публичный адрес.

* Так же, вы можете выгрузить лог в отдельный файл для удобства работы нажав "Download logs".

* Если вы наблюдаете подобные ошибки - значит ваша нода пока не подключилась, дайте ей немного времени.

 ![image](https://user-images.githubusercontent.com/23629420/172899186-5ba923c0-8cf3-435b-8fbb-5f5e64d38459.png)

 
### Спасибо что используете Akash Network!


