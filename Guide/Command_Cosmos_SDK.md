## Commands for the command line of Cosmos SDK ecosystem projects.
## Команды для командной строки проектов экосистемы Cosmos SDK.

> $BINARY - here is the binary file of the project, each has its own, like denom and chain-id
 
> $BINARY - здесь бинарный файл проекта, у каждого он свой, как и denom и chain-id

 1. [Account (wallet) commands | Команды аккаунта (кошелька)](https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/COMMAND.MD#account-wallet-commands)
 2. [Validator Commands | Команды валидатора](https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/COMMAND.MD#validator-commands)
 3. [Voting commands | Команды голосования](https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/COMMAND.MD#voting-commands)
 4. [Network settings commands | Команды настроек сети](https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/COMMAND.MD#network-settings-commands)
 
##### Account (wallet) commands
 
##### Команды аккаунта (кошелька)

Create wallet | Cоздать кошелек

```
$BINARY keys add <WALLET_NAME> --keyring-backend os
```

Restore wallet (after insert seed command) | Восстановить кошелек (после команды вставить seed)

```
$BINARY keys add <WALLET_NAME> --recover --keyring-backend os
```

Connect ledger wallet | Подключить кошелек ledger

```
$BINARY keys add <WALLET_NAME> --ledger 
```

Check balance | Проверить баланс

```
$BINARY q bank balances <ADDRESS>
```

Send 1 token to another address | Отправить 1 токен на другой адрес

```
$BINARY tx bank send <ADDRESS_FROM> <ADDRESS_TO> 1000000$DENOM --fees 500$DENOM -y
```

[UP | Наверх](https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/COMMAND.MD#commands-for-the-command-line-of-cosmos-sdk-ecosystem-projects) .

##### Validator Commands
##### Команды валидатора

Create a validator | Создать валидатора

```
$BINARY tx staking create-validator --amount="1000000$DENOM" --pubkey=$($BINARY tendermint show-validator) --moniker="$MONIKER"	--chain-id="$CHAIN"	--commission-rate="0.10" --commission-max-rate="0.20" --commission-max-change-rate="0.01" --min-self-delegation="1000000" --gas="auto"	--from="$address" --fees="555$DENOM" -y
```

Check validator pubkey | Проверить pubkey валидатора

```
$BINARY tendermint show-validator
```

Check validator | Проверить валидатора

```
$BINARY query staking validator <valoper_address>
```

```
$BINARY query staking validators --limit 1000000 -o json | jq '.validators[] | select(.description.moniker=="$MONIKER")' | jq
```
  
Collect commissions + rewards | Собрать комиссионные + реварды

```
$BINARY tx distribution withdraw-rewards <valoper_address> --from <ADDRESS> --fees 500$DENOM --commission -y
```

Delegate 1 ooo ooo 'u'token to yourself | Заделегировать себе  1 000 000 'u'токен

```
$BINARY tx staking delegate <valoper_address> 1000000$DENOM --from <ADDRESS> --fees 500$DENOM -y
```

[UP | Наверх](https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/COMMAND.MD#commands-for-the-command-line-of-cosmos-sdk-ecosystem-projects) .
  
##### Voting commands
##### Команды голосования
  
Proposal list | Список предложений

```
$BINARY q gov proposals
```
  
View the result of the vote | Посмотреть результат голосования

```
$BINARY q gov proposals --voter <ADDRESS>
```
  
Vote for the proposal | Проголосовать за предложение 

```
$BINARY tx gov vote 1 yes --from <ADDRESS> --fees 555$DENOM
```
  
Make a deposit to the proposal | Внести депозит в предложение

```
$BINARY tx gov deposit 1 1000000$DENOM --from <ADDRESS> --fees 555$DENOM
```

Create an proposal | Создать предложение

```
$BINARY tx gov submit-proposal --title="Randomly reward" --description="Reward 10 testnet participants who completed more than 3 tasks" --type="Text" --deposit="11000000$DENOM" --from <ADDRESS> --fees 500$DENOM
```
  
[UP | Наверх](https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/COMMAND.MD#commands-for-the-command-line-of-cosmos-sdk-ecosystem-projects) .
  
  
##### Network settings commands

##### Команды настроек сети
  
Network settings | Параметры сети

```
$BINARY q staking params
```

```
$BINARY q slashing params
```

Get out of jail | Выбраться из тюрьмы

```
$BINARY tx slashing unjail --from <ADDRESS> --fees 500$DENOM -y
```

```
$BINARY q slashing signing-info $($BINARY tendermint show-validator)
```

Check Status | Проверить статус

```
curl localhost:26657/status
```

[UP | Наверх](https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/COMMAND.MD#commands-for-the-command-line-of-cosmos-sdk-ecosystem-projects) .
