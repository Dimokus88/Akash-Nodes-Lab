<div align="center">
  
![pba](https://user-images.githubusercontent.com/23629420/163564929-166f6a01-a6e2-4412-a4e9-40e54c821f05.png)
# Cloudmos(Akashlytics) - custom user interface, overview and guide.

  </div>
  
<div align="center">

| [Akash Network](https://akash.network/) | [Forum Akash Network](https://forum.akash.network/) | 
|:--:|:--:|
___

Our news channels and technical support:

| [Discord Akash](https://discord.gg/WR56y8Wt) | [Telegram Akash EN](https://t.me/AkashNW) | [TwitterAkash](https://twitter.com/akashnet_) | 
|:--:|:--:|:--:|

Before you begin, ***[download and install](https://cloudmos.io/cloud-deploy) the Cloudmos(Akashlytics)*** software on your work computer.
  
</div>

___

#### In this guide:
1. [Create an account and prepare for work](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#create-an-account-and-prepare-for-work).
2. [Open Deployment](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#test-deploy).
3. [Deployment window content.](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#deployment-window-content)
4. [Close Deployment](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#close-deployment)
5. [Overview Cloudmos(Akashlytics)](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#overview-of-cloudmos-functionality)

___

## Create an account and prepare for work.

After installation, at the first start, you will be prompted to create an address on the ```Akash``` network or import an existing one by seed phrase:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179983489-a8b76248-edea-4356-8e87-3ec2761ae8b8.png" width=30% </p>

When choosing to create a new account (wallet), you will be shown a seed phrase about it, save it in a safe place. And also specify the name of the future account (wallet) and password to it:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179984081-47586ff3-76bb-4951-9c44-50e68e95fac9.png" width=30% </p>

Check the integrity of the seed phrase by placing the words in the correct order:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179984518-4d68dba5-2914-40e5-a8d1-8c193c7db6f3.png" width=30% </p>

Done, account successfully created!
  
The AKT token can be purchased on the ```Gate```, ```AsendeX```, ```Osmosis``` exchanges. Please note that with each deployment, ***5 AKT*** are blocked on the account + a small amount of AKT is required to pay for gas. Thus, for the test it would be better to replenish the account with ***6 AKT***.
  
In the example, I will replenish the test account ```akash1wnejkh7vfjxcavmt43dratujdw5vkzynt94zrg``` with ***6 AKT***.

The account has been replenished, now you need to request and install a certificate from the blockchain locally, for this, click ***CREATE CERTIFICATE*** in the upper right  

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179985902-ac2a82cd-522c-4a24-b1d6-6f5c16f24fbe.png" width=60% </p>

Enter the password specified when ***creating an account***:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179986384-90fc70fe-3c6e-4a71-8592-ccd2d04dcb7c.png" width=30% </p>

Select the transaction fee and confirm the transaction:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179986643-a41816cc-5338-4036-8fa6-b4a2ceabdf54.png" width=30% </p>

The certificate has been created, you can see it in the upper right corner of the window:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179986849-36066744-450f-440a-a392-542afcc3b883.png" width=50% </p>

Preparation is complete, now create a test deploy.

[Return](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#in-this-guide)
  
___

## Test deploy.

***Cloudmos(Akashlytics)*** has ready-made ***manifest files (deploy.yml)***, they are in the ```Templates``` tab, check out the offer of ready-made solutions:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179993135-a0b5f5d1-8236-41f1-886b-8bfe664c8358.png" width=60% </p>

Let's deploy the well-known game ***Super Mario***, to do this, select the appropriate section in ```Templates``` and click on ```Super Mario```:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179993710-bdf5464e-a8cf-4426-857a-92ae80d7f3c7.png" width=60% </p>

Click ***Deploy***: 
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179993892-8a2b96bb-b529-46f7-92bb-2f5e34ac3c87.png" width=60% </p>

***Cloudmos*** checks for the presence of a certificate and ***5 AKT*** on the balance, and opens the completed ***manifest window (deploy.yml)***, let's dwell on the contents of the manifest:  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179994491-9ddb00f5-14ea-4430-ae43-1d23e406c854.png" width=60% </p>

Here pay attention to:

Section ```services``` (lines 4-11). Line 6 specifies the image in ***Docker hub*** from which the container will be deployed, in our case it is ```pengbai/docker-supermario```. The ***expose*** subsection is responsible for opening and forwarding ports. In our case, this port 8080 is represented as 80 external.

Section ```profiles``` (lines 13-22) here in the subsection ```resources``` we indicate the rented characteristics of the equipment for our container with the game ***Super Mario***. In our case, this is ```1 cpu, 512 MB of RAM and 512 MB of hard disk```. Enter a name for the deployment at the top and click ***CREATE DEPLOYMENT***.  

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179996364-3f4591e3-731c-41b3-91ae-d580fc6bad8e.png" width=30% </p>

We deposit ***5 AKT*** from our account, press ```DEPOSIT```:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179996501-52b33027-2be4-4791-b238-93ca79de8e47.png" width=30% </p>

Set the transaction fee amount and confirm it. At this stage, we have sent a resurces request to the network for our game container. We just have to wait for a response from providers with their offers and prices. ***Please note that 5 AKT have been deposited from your account***.  

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179997193-2c4793bf-392f-4d7d-81a9-8e1326083cf2.png" width=30% </p>

Select a provider and press ```ACCEPT BID```, once again set the commission for the transaction and confirm it. We are waiting for the container to be deployed. Once the container is deployed, go to the ```LEASES``` tab. 

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179997878-7d6eb433-24ef-4b67-b829-d47c858553bd.png" width=30% </p>

Here you can find information about your provider, the cost of renting, as well as an individual link to your deployment. Click it.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/179998220-473b42ec-144f-4bff-b640-801fc727983b.png" width=60% </p>

Excellent! Looks like you deployed the game to ***Akash Network***! But do you need something more than a game? Then go to the functional description section ***Cloudmos*** =)
  
[Return](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#in-this-guide)
  
___  
  
## Deployment window content.

The ```Dashboard``` tab displays your active deployments, go to it.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180011860-0b25c946-c681-42e5-92eb-53685e42233c.png" width=60% </p>

As we learned earlier, the ```LEASES``` tab contains general information about the deployment - provider, resources, forwarded ports and links.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180012152-b6245abd-6be0-4030-ba1f-be4a9c9c2339.png" width=60% </p>

There are 2 more subsections in the ```LOGS``` tab, this is the ```LOGS``` subsection - logs ***INSIDE*** of the container are displayed here (by clicking the ```DOWNLOADS LOGS``` button you can download them in file):
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180012615-25fd934f-b191-415a-9994-d9449bc71cdf.png" width=50% </p>

and the ```EVENTS``` subsection - here you can see ***k8s*** logs and the process of downloading and starting your image:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180013447-fc46589d-70df-486e-92cd-9cad9571824a.png" width=50% </p>

On the ```SHELL``` tab, you can use some ***NOT interactive*** commands inside the container:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180014038-5a6157d5-8329-4ffd-8feb-a3414050434e.png" width=50% </p>

The ```UPDATE``` tab contains the current ***manifest (deploy.yml)***, here you can add variables or change the image version, in which case the container will be restarted. ***(IMPORTANT! Resources cannot be changed! To do this, close deployment and redeploy!).***

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180014538-95597f58-1d4b-4bc7-9ed4-eba9339b3a58.png" width=50% </p>

The ```RAW DATA``` tab contains ```JSON``` information from the ```AKASH``` blockchain:
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180014764-02b11971-e727-4156-8eb6-5e1900f2f1f1.png" width=50% </p>

[Return](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#in-this-guide)

___
  
 
## Close deployment.

To close the deployment, you need to click ```CLOSE``` in the context menu and confirm the transaction:

<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180015653-5471583b-51fa-4940-819e-79d1d518b826.png" width=60% </p>
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180015752-d304b327-45fc-4629-93f2-7e79c0505931.png" width=30% </p>


After the deployment is closed, the balance of ***AKT*** will be returned to your main account.
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180015965-c3044adc-4352-428c-9d1e-cec2f3e38ae9.png" width=60% </p>


[Return](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#in-this-guide)

___

  
### Overview of Cloudmos functionality.
  
***Dashboard*** - here your current balance account (1), current network lease status(2) and your active deployment deployments(3).
  
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180029956-c9c5ac9f-ee58-4242-ab3b-82c374ee7379.png" width=60% </p>

***Deployments*** - all deployments ever created on your address, including those that are not active.
  
  <p align="center"><img src="https://user-images.githubusercontent.com/23629420/180030091-a9ccf0ee-ecbf-4d18-a005-17bb09ab9cd9.png" width=60% </p>

***Templates*** - turnkey solutions for deployments, games, databases, website builders, miner, etc.
    
  <p align="center"><img src="https://user-images.githubusercontent.com/23629420/180030306-92134590-17c3-4bf0-9032-79245425755f.png" width=60% </p>
  
***Provider*** - a list of existing providers in the Akash Network marketplace with the parameters of their equipment.
    
 <p align="center"><img src="https://user-images.githubusercontent.com/23629420/180030505-c704159c-6820-4d86-8ea6-66c5eedb71b5.png" width=60% </p> 

***Settings*** - configuring the RPC node of the application (1). Quick switching is also available in the field at the top of the window (2)
   
<p align="center"><img src="https://user-images.githubusercontent.com/23629420/180031581-545f3439-702d-45e2-8d53-3d4f97d845ce.png" width=60% </p>
  
[Return](https://github.com/Dimokus88/Akash-Nodes-Lab/blob/main/Guide/Cloudmos(Akashlytics)_EN.md#in-this-guide)

___
