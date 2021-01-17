---
title: "Sécurité Web 1"
author: [Olivier LASNE]
date: "2021-01-18"
subject: "Markdown"
keywords: [Sécuirté Web]
subtitle: ""
lang: "fr"
titlepage: true
...

# Sécurité Web

Pour ce TP nous utiliserons la machine __OWASP Broken Web Apps__ que vous avez déjà. Et l'iso __"From SLQi to Shell"__ que vous pouvez télécharger ici :

__[https://pentesterlab.com/exercises/from_sqli_to_shell/iso](https://pentesterlab.com/exercises/from_sqli_to_shell/iso)__

## SQL

SQL est un langage de requêtes de base de données.

Vous pouvez vous connecter en SSH à votre VM OWASP Broken Web Apps en SSH. `root/owaspbwa`.

`ssh root@192.168.56.101` (remplacer avec l'IP de la machine)

On peut y lancer MySQL avec la commande suivante :
`mysql -u root -powaspbwa`

Cela lance un shell MySQL. On obtient de l'aide avec la command `help` ou `\h`.
```
mysql> help

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.

For server side help, type 'help contents'
```

On peut voir les bases de données avec la commande `show databases;`

```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| .svn               |
| bricks             |
| bwapp              |
| citizens           |
| cryptomg           |
| dvwa               |
| gallery2           |
| getboo             |
| ghost              |
| gtd-php            |
| hex                |
| isp                |
| joomla             |
| mutillidae         |
| mysql              |
| nowasp             |
| orangehrm          |
| personalblog       |
| peruggia           |
| phpbb              |
| phpmyadmin         |
| proxy              |
| rentnet            |
| sqlol              |
| tikiwiki           |
| vicnum             |
| wackopicko         |
| wavsepdb           |
| webcal             |
| webgoat_coins      |
| wordpress          |
| wraithlogin        |
| yazd               |
+--------------------+
34 rows in set (0.00 sec)
```

On selectionne une base avec la commande __`use`__ :

```
mysql> use peruggia;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
```

On peut ensuite lister les tables avec la commande __`show tables;`__ :
```
mysql> show tables;
+--------------------+
| Tables_in_peruggia |
+--------------------+
| picdata            |
| users              |
+--------------------+
2 rows in set (0.00 sec)
```

__/!\ Les commandes `show` et `help` sont des commandes du SHELL MySQL. Il ne s'agit pas de requêtes SQL valides.__

On peut selectionner l'ensemble des champs d'un tables avec la requête `SELECT * FROM nom_de_la_table`.\
Le caractère `*` signifie _tout les champs_.

```
mysql> SELECT * FROM users;
+----+----------+----------------------------------+
| ID | username | password                         |
+----+----------+----------------------------------+
|  1 | admin    | 21232f297a57a5a743894a0e4a801fc3 |
|  2 | user     | ee11cbb19052e40b07aac0ca060c23ee |
+----+----------+----------------------------------+
2 rows in set (0.00 sec)
```

On peut selectionner un seulement certains champs, en les listants séparés par des virgules.
```
mysql> SELECT ID, username FROM users;
+----+----------+
| ID | username |
+----+----------+
|  1 | admin    |
|  2 | user     |
+----+----------+
2 rows in set (0.00 sec)
```

Note : il n'est pas nécessaire de mettre `SELECT` et `FROM` en majuscule. Néanmoins il s'agit de la convention prise dans la plupart des cas de façon à distinguer les champs des opérateurs.
