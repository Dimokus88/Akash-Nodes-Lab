# Создание ключей валидатора Ethereun 2.0
1. Перейдите на страницу с релизами и скопируйте ссылку актуальной версии
![image](https://user-images.githubusercontent.com/23629420/203358990-13b99c9f-1c02-4cd1-897f-39652d6861a6.png)

2. выполните в терминале Linux:
``` 
mkdir /tmp/deposit/ && \
wget -O /tmp/deposit.tar.gz https://github.com/ethereum/staking-deposit-cli/releases/download/v2.1.0/staking_deposit-cli-ce8cbb6-linux-amd64.tar.gz && \
tar -C /tmp/deposit/ -xf "/tmp/deposit.tar.gz" --strip-components 2 && \
deposit=/tmp/deposit/`ls /tmp/deposit` && \
rm /tmp/deposit.tar.gz
```
3. После установки проверьте работу командой `$deposit --help` ответ можете увидеть на скринешоте ниже:
![image](https://user-images.githubusercontent.com/23629420/203371388-d5f96ab6-2eec-440b-9d4f-6327bcfac431.png)

4. Создайте аккаунт командой ниже, обратите внимание на флаги: `--num_validators` укажите сколько валидаторов хотите запустить, а так же `--chain`-укажите сеть
```
$deposit new-mnemonic --num_validators 2 --chain goerli
```
