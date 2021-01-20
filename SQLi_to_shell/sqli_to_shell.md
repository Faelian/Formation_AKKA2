---
title: "From SQLi to Shell"
author: [Olivier LASNE]
date: "2021-01-19"
subject: "Markdown"
keywords: [Sécuirté Web]
subtitle: "Exploitation de la machine"
lang: "fr"
titlepage: true
...

# Installation de "From SLQi to Shell"

Il s'agit d'une machine virtuelle faite par PentesterLab volontairement vulnérable. Elle permet de réaliser un scénario d'attaque complet sur une machine "réaliste".

Une correction officielle de la machine est disponible ici : [https://pentesterlab.com/exercises/from_sqli_to_shell/course](https://pentesterlab.com/exercises/from_sqli_to_shell/course)

## Télécharger le fichier ISO

Le fichier iso peut être télécharger ici:\
__[https://pentesterlab.com/exercises/from_sqli_to_shell/iso](https://pentesterlab.com/exercises/from_sqli_to_shell/iso)__

## Installation dans VirtualBox

### Création d'une nouvelle VM

Dans VirtualBox, cliquer sur le bouton **Nouvelle**. ![](./images/nouvelle.png)

Donner un nom (ex: "SQLi to Shell"), puis choisir type **Linux** et version **debian32**.

![](images/systeme.png)

Cliquer sur __Créer__.

------

Laisser les options de __Taille de mémoire__ et de __Disque dur__ par __défaut__.

Vous pouvez ensuite également laisser l'__emplacement du fichier__ et sa __taille__ par __défaut__.

![](images/emplacement_et_taille.png)

Cliquer sur __Créer__.

### Ajout du live CD

Selectionner dans Virtualbox la VM nouvellement créée.

![Selection de la machine](images/selection_machine.png)

Et cliquer sur l'icone Configuration. ![](./images/config_ico.png)

Selectionner **Stockage > *Vide* sous Contrôleur IDE**.

![](./images/stockage.png)

Cliquer sur l'icone de CD ![](./images/cd_icon.png){height=20}, et **Choissisez un fichier de disque optique virtuel**. Et sélectionner le fichier *from_sqli_to_shell_i386.iso* téléchagé précédement.

Appuyer sur **OK** en bas à droite pour confirmer les modifications. 

## Configuration réseau

Pour attaquer la VM vulnérable, on va préférer un mode "réseau privé hôte".

À nouveau, __selectionner__ la VM __"SQLi to Shell"__ dans VirtualBox et cliquer sur l'icone __Configuration__. ![](./images/config_ico.png)

1. Aller dans __Réseau > Apdater 1__
2. Pour _Mode d'accès réseau_ sélectionner __Réseau privé hôte__
3. Dans _Nom :_ sélectionner __vboxnet0__ (réseau de votre Kali)
4. Cliquer sur __OK__ pour confirmer les changement

![Configuration en réseau privé hôte](images/config_r%C3%A9seau.png)

## Lancer la VM

On peut mantenant lancer la machine virtuelle avec le bouton **Démarrer**. ![](./images/demarrer.png).

Il est possible qu'au démarrage, la VM vous __redemande le fichier ISO__ à utiliser. Dans ce cas, selectionner bien *from_sqli_to_shell_i386.iso*.

![Selection de l'iso au démarrage](images/choix_iso.png)

L'installation est terminée.

S'agissant d'un Live CD. La machine démarrera à chaque fois sur le fichie ISO sans conserver les changement qui ont été effectués dessus.

\newpage

# Pentest

Lorsqu'elle démarre. La machine vous donne un shell (avec un clavier QWERTY).\
Vous pouvez utiliser la commande `ifconfig` pour trouver l'IP de la machine.

![Trouver l'IP de la machine](images/ifconfig.png)

## Scan de port

La première chose à faire lorque l'on a une machine a tester est un scan de ports avec `nmap`. Vous pouvez faire cela avec votre __Kali Linux__.

Pour un scan de port complet, rajouter l'option `-p-`.

```
nmap -sV -sC 192.168.56.112 -oN scan_tcp.nmap

Starting Nmap 7.60 ( https://nmap.org ) at 2021-01-20 12:14 CET
Nmap scan report for ubuntu32 (192.168.56.112)
Host is up (0.00014s latency).
Not shown: 998 closed ports
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 5.5p1 Debian 6+squeeze2 (protocol 2.0)
| ssh-hostkey: 
|   1024 18:53:14:47:58:80:c3:98:fd:39:f7:69:02:f9:46:79 (DSA)
|_  2048 b2:ed:5b:ea:4d:9b:aa:b8:b5:2f:a0:37:86:44:22:aa (RSA)
80/tcp open  http    Apache httpd 2.2.16 ((Debian))
|_http-server-header: Apache/2.2.16 (Debian)
|_http-title: My Photoblog - last picture
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 6.74 seconds
```

On a ici deux services : un serveur SSH port 22, et un serveur Web sur le port 80.

Port | service
-----|--------
tcp/22 | SSH
tcp/80 | HTTP (web)

## HTTP : tcp/80

## Énumération

Lorsque l'on a un serveur web, on va systématiquement lancer quelques scans.

### Nikto

Nikto est un scanner web un peu ancien, qui remonte souvent des faux positifs. Il peut néanmoins avoir quelques informations utiles.

Sous Kali, nikto se lance avec `nikto -h ip_cible`.\
On peut stocker les résultats un `tee`.

```bash
$ nikto -h 192.168.56.112 | tee scan_nikto.txt

- Nikto v2.1.6
---------------------------------------------------------------------------
+ Target IP:          192.168.56.112
+ Target Hostname:    192.168.56.112
+ Target Port:        80
+ Start Time:         2021-01-20 12:23:28 (GMT1)
---------------------------------------------------------------------------
+ Server: Apache/2.2.16 (Debian)
+ Retrieved x-powered-by header: PHP/5.3.3-7+squeeze14
+ The anti-clickjacking X-Frame-Options header is not present.
...

```

Il ne nous remonte ici pas grand chose d'intéressant si ce n'est des erreurs de configuration.

### Gobuster
