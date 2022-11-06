<div align="center">
  
![pba](https://user-images.githubusercontent.com/23629420/163564929-166f6a01-a6e2-4412-a4e9-40e54c821f05.png)
# Обзор и руководство по использованию кастомного пользовательского интерфейса Cloudmos(Akashlytics).

  </div>
  
<div align="center">

| [Akash Network](https://akash.network/) | [Forum Akash Network](https://forum.akash.network/) | 
|:--:|:--:|
___

Наши новостные каналы и русскоязычная техническая поддержка:

| [Discord Akash](https://discord.gg/WR56y8Wt) | [Telegram Akash EN](https://t.me/AkashNW) | [Telegram Akash RU](https://t.me/akash_ru) | [TwitterAkash](https://twitter.com/akashnet_) | [TwitterAkashRU](https://twitter.com/akash_ru) |
|:--:|:--:|:--:|:--:|:--:|

Перед началом ознакомления ***[скачайте и установите](https://cloudmos.io/cloud-deploy) ПО Cloudmos(Akashlytics)*** на свой рабочий компьютер.
  
</div>

___

#### В этой статье:
1. [Создание аккаунта и подготовка к кработе](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B0%D0%BA%D0%BA%D0%B0%D1%83%D0%BD%D1%82%D0%B0-%D0%B8-%D0%BF%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BA%D0%B0-%D0%BA-%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D0%B5).
2. [Создать развертывание](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2%D0%BE%D0%B5-%D1%80%D0%B0%D0%B7%D0%B2%D0%B5%D1%80%D1%82%D1%8B%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5).
3. [Содержимое окна разветывания](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D1%81%D0%BE%D0%B4%D0%B5%D1%80%D0%B6%D0%B8%D0%BC%D0%BE%D0%B5-%D0%BE%D0%BA%D0%BD%D0%B0-%D1%80%D0%B0%D0%B7%D0%B2%D0%B5%D1%80%D1%82%D1%8B%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)
4. [Закрыть развертывание](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D0%B7%D0%B0%D0%BA%D1%80%D1%8B%D1%82%D1%8C-%D1%80%D0%B0%D0%B7%D0%B2%D0%B5%D1%80%D1%82%D1%8B%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5)
5. [Обзор Cloudmos(Akashlytics)](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D0%BE%D0%B1%D0%B7%D0%BE%D1%80-%D1%84%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D0%B0-cloudmosakashlytics)

___

## Создание аккаунта и подготовка к работе.

После установки, при первом запуске, будет предложено создать адрес в сети ```Akash``` или экспортировать уже имеющийся по seed-фразе:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179983489-a8b76248-edea-4356-8e87-3ec2761ae8b8.png" width=30% </p>

При выборе создания нового аккаунта (кошелька), Вам будет показана seed-фраза к нему, сохраните ее в надежном месте. А также, укажите название будущего аккаунта (кошелька) и пароль к нему:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179984081-47586ff3-76bb-4951-9c44-50e68e95fac9.png" width=30% </p>

Выполните проверку сохранности seed-фразы, расположив слова в правильном порядке:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179984518-4d68dba5-2914-40e5-a8d1-8c193c7db6f3.png" width=30% </p>

Готово, аккаунт успешно создан!
  
   Токен АКТ можно пробрести на биржах ```Gate```, ```AsendeX```, ```Osmosis``` . Следует учитывать, что при каждом развертывании на счете блокируются ***5 AKT*** + требуется небольшое количество AKT для оплаты газа. Таким образом, для теста достаточно пополнить счет на ***6 АКТ***.
  
 В примере я пополню тестовый счет ```akash1wnejkh7vfjxcavmt43dratujdw5vkzynt94zrg``` на ***6 АКТ***.

Счет пополнен, теперь необходимо запросить и установить локально сертификат из блокчейна, для этого справа вверху нажмите ***CREATE CERTIFICATE***
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179985902-ac2a82cd-522c-4a24-b1d6-6f5c16f24fbe.png" width=60% </p>

Введите пароль указанный при ***создании аккаунта***:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179986384-90fc70fe-3c6e-4a71-8592-ccd2d04dcb7c.png" width=30% </p>

Выберите комисиию за транзакцию и поддтвердите транзакцию:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179986643-a41816cc-5338-4036-8fa6-b4a2ceabdf54.png" width=30% </p>

Сертификат создан, Вы можете его увидеть в правом верхнем углу окна:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179986849-36066744-450f-440a-a392-542afcc3b883.png" width=50% </p>

Подготовка завершена, теперь сделаем тестовое разветывание.

[Вернуться к содержанию.](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D0%B2-%D1%8D%D1%82%D0%BE%D0%B9-%D1%81%D1%82%D0%B0%D1%82%D1%8C%D0%B5)
  
___

## Тестовое развертывание

В ***Cloudmos(Akashlytics)*** есть готовые файлы ***манифеста (deploy.yml)***, они находятся во вкладке ```Templates```, ознакомьтесь с предложением готовых решений: 
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179993135-a0b5f5d1-8236-41f1-886b-8bfe664c8358.png" width=60% </p>

Развернем всем известную игру ***Super Mario***, для этого выберем соответствующий раздел в ```Templeates``` и нажмем на ```Super Mario```:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179993710-bdf5464e-a8cf-4426-857a-92ae80d7f3c7.png" width=60% </p>

Нажимаем ***Deploy***: 
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179993892-8a2b96bb-b529-46f7-92bb-2f5e34ac3c87.png" width=60% </p>

***Cloudmos(Akashlytics)*** быстро проверяет наличие сертификата и ***5 АКТ*** на балансе, и открывает заполненное окно ***манифеста (deploy.yml)***, остановимся на содержимом манифеста:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179994491-9ddb00f5-14ea-4430-ae43-1d23e406c854.png" width=60% </p>

Здесь обратите внимание на:

Раздел ```services``` (строки 4-11). В строке 6 указан образ в ***Docker hub*** из которого будет развернут контейнер, в нашем случае это ```pengbai/docker-supermario```. Подраздел ***expose*** отвечает за открытия и переадресацию портов. В нашем случае порт 8080 представляем, как 80 внешний.

Раздел ```profiles``` (строки 13-22) здесь в подразделе ```resources``` мы указываем арендуемые характеристики оборудования под наш контейнер с игрой ***Super Mario***. В нашем случае это ```1 cpu, 512 мб ОЗУ и 512мб жесткого диска```. Задайте ввеху имя развертывания и нажимите ***CREATE DEPLOYMENT***.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179996364-3f4591e3-731c-41b3-91ae-d580fc6bad8e.png" width=30% </p>

Депонируем ***5 АКТ*** из нашего счета, нажимаем ```DEPOSIT```:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179996501-52b33027-2be4-4791-b238-93ca79de8e47.png" width=30% </p>

Устанавливаем размер комиссии за транpакцию и подтверждаем ее. На данном этапе мы отправили в сеть запрос на мощности для нашего конетйнера с игрой. Нам остается дождаться ответа от провайдеров с их предложениями и ценами. ***Обратите внимание, у Вас со счет были депонированы 5 АКТ***.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179997193-2c4793bf-392f-4d7d-81a9-8e1326083cf2.png" width=30% </p>

Выбираем провайдера и нажимаем ```ACCEPT BID```, еще раз устанавливаем комиссию для транзакиции и подтверждаем ее. Дожидаемся развертки контейнера. После того, как контейнер развернут, перейдите на вкладку ```LEASES```.
 
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179997878-7d6eb433-24ef-4b67-b829-d47c858553bd.png" width=30% </p>

Здесь доступна информация о Вашем провайдере, стоимости аренды, а также индивидуальная ссылка на Ваше развертывание. Нажмите на нее.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179998220-473b42ec-144f-4bff-b640-801fc727983b.png" width=60% </p>

Отлично! Похоже, Вы развернули игру в Akash Network! Но Вам же нужно нечто большее, чем игра? Тогда перейдите к разделу описания функционала ***Cloudmos(Akashlytics)*** =)
  
[Вернуться к содержанию.](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D0%B2-%D1%8D%D1%82%D0%BE%D0%B9-%D1%81%D1%82%D0%B0%D1%82%D1%8C%D0%B5)
  
___  
  
## Содержимое окна развертывания

Во вкладке ```Dashboard``` отображаются Ваши активные разветывания, зайдите в него.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180011860-0b25c946-c681-42e5-92eb-53685e42233c.png" width=60% </p>

Как узнали раннее, во вкладке ```LEASES``` содержится общая информация о развертывании - провайдер, ресурсы, переадресованный порты и ссылки.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180012152-b6245abd-6be0-4030-ba1f-be4a9c9c2339.png" width=60% </p>

Во вкладке ```LOGS``` есть еще 2 подраздела, это подраздел ```LOGS``` - здесь отображаются логи ***ВНУТРИ*** контейнера (нажав кнопку ```DOWNLOADS LOGS```, можно их скачать в файл):

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180012615-25fd934f-b191-415a-9994-d9449bc71cdf.png" width=50% </p>

и подраздел ```EVENTS``` - здесь отображаются логи ***k8s*** и процесс скачивания и старта Вашего образа:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180013447-fc46589d-70df-486e-92cd-9cad9571824a.png" width=50% </p>

На вкладке ```SHELL``` можете использовать некоторые ***НЕ интерактивные*** команды внутри контейнера
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180014038-5a6157d5-8329-4ffd-8feb-a3414050434e.png" width=50% </p>

Вкладка ```UPDATE``` содержит текущий ***манифест (deploy.yml)***, здесь Вы можете добавить переменные или изменить версию образа, в этом случае контейнер будет перезапущен. ***(ВАЖНО! Нельзя изменить ресурсы! Для этого надо закрыть равертывание и развернуть заново!).***
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180014538-95597f58-1d4b-4bc7-9ed4-eba9339b3a58.png" width=50% </p>

Вкладка ```RAW DATA``` содержит ```JSON``` информацию из блокчейна ```AKASH```
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180014764-02b11971-e727-4156-8eb6-5e1900f2f1f1.png" width=50% </p>

[Вернуться к содержанию.](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D0%B2-%D1%8D%D1%82%D0%BE%D0%B9-%D1%81%D1%82%D0%B0%D1%82%D1%8C%D0%B5)

___
  
 
## Закрыть развертывание

Чтобы закрыть развертывание, необходимо в контекстном меню нажать ```CLOSE``` и подтвердить транзакцию

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180015653-5471583b-51fa-4940-819e-79d1d518b826.png" width=60% </p>
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180015752-d304b327-45fc-4629-93f2-7e79c0505931.png" width=30% </p>


После закрытия развертывание остаток ***АКТ*** вернется на Ваш основной счет.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180015965-c3044adc-4352-428c-9d1e-cec2f3e38ae9.png" width=60% </p>


[Вернуться к содержанию.](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D0%B2-%D1%8D%D1%82%D0%BE%D0%B9-%D1%81%D1%82%D0%B0%D1%82%D1%8C%D0%B5)

___

  
### Обзор функционала Cloudmos(Akashlytics).
  
***Dashboard*** - здесь указаны актуальные параметры Вашего счета(1), текущее состояние аренды в сети(2) и Ваши активные развертывания(3).
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180029956-c9c5ac9f-ee58-4242-ab3b-82c374ee7379.png" width=60% </p>

***Deployments*** - все, когда-либо созданные, разветывания на Вашем адресе, включая не активные.
  
  <p align="center"><img src="https://user-images.githubusercontent.com/23629420/180030091-a9ccf0ee-ecbf-4d18-a005-17bb09ab9cd9.png" width=60% </p>

***Templates*** - готовые решения для развертываний, игры, БД, конструкторы сайтов, майнер и т.д..
    
  <p align="center"><img src="https://user-images.githubusercontent.com/23629420/180030306-92134590-17c3-4bf0-9032-79245425755f.png" width=60% </p>
  
***Provider*** - список существующих провайдеров в маркетплейсе Akash Network с параметрами их оборудования.
    
 <p align="center"><img src="https://user-images.githubusercontent.com/23629420/180030505-c704159c-6820-4d86-8ea6-66c5eedb71b5.png" width=60% </p> 

***Settings*** - настройка RPC ноды приложения (1). Так же доступно быстрое переключение в поле вверху окна (2).
   
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180031581-545f3439-702d-45e2-8d53-3d4f97d845ce.png" width=60% </p>
  
[Вернуться к содержанию.](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_RU.md#%D0%B2-%D1%8D%D1%82%D0%BE%D0%B9-%D1%81%D1%82%D0%B0%D1%82%D1%8C%D0%B5)

___
