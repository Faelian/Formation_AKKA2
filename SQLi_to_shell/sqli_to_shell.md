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

