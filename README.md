# Wallet App

This is app made by Catarina Nunes, from Universidade de Évora , student number m42012.
This app is done using Flutter. 
Flutter is an app SDK for building high-performance, high-fidelity apps for iOS, Android, web (beta), and desktop (technical preview) from a single codebase. 
Flutter will need to be installed to run this application, please refer to README.md for more resources about Flutter. 
So far this app was only tested in Android.

## What is this app?

This app is a simple wallet app were you can keep a record of your expenses and incomes.

<img src="https://github.com/ctanunes/walletapp/blob/master/images/device-2020-06-21-195144.png" width="300"/>  <img src="https://github.com/ctanunes/walletapp/blob/master/images/device-2020-06-21-195351.png" width="300"/>  <img src="https://github.com/ctanunes/walletapp/blob/master/images/device-2020-06-21-195426.png" width="300"/>  <img src="https://github.com/ctanunes/walletapp/blob/master/images/device-2020-06-21-195448.png" width="300"/>

## What will you be able to do with this app?

You will be able to:
* Keep a running value of money you have available
* Create Budgeted Items
  * Create budget items for upcoming income
  * Create budget items for upcoming expenses
* Set up goals and make "transfers" from your available values to this goals - sort of like saving pots;
* Visually see your progression on your goals
* See how much you need to add to reach your goals

## Other resources about this app

Please look for wallet_app_wireframe.png for a look at the planed wireframe for this app.
Final app will not look like the wireframe, this is only a guideline for development.
And click through the wireframe using this link [Link for prototype](https://xd.adobe.com/view/4ce26be6-900b-421c-439f-ff58f68cc95d-3ad3/)
![alt text](https://github.com/ctanunes/walletapp/blob/master/images/wallet_app_wireframe.png)

## TODO
## Done

- [x] Make wireframes
- [x] Setup data models, for budget items, goals etc..
- [x] Make Floating Button
- [x] Make Floating Button Options
- [x] Make widget for budget item tile
- [x] Make widget for budget item list
- [x] Make widget for Goal item tile
- [x] Make widget for Goal item list
- [x] Make widget for Main value remaining tile
- [x] Make Add Budget item Screen
- [x] Improve Theme and Style of the App

# Details in Portuguese
## Tecnologias e conceitos abordados neste projecto
Este projecto foi o meu projecto primeiro a utilizador o Flutter, por essa razão foi necessário estudar a liguagem que o Flutter usa: Dart.
Dart é muito parecido que Javascript e Typescript, que são linguagens de que já tinha alguma familiaridade. 

A aplicação está estruturada em components, models, screens and services.
Components são widgets e são components do layout da aplicação.
Models são classes dos objectos da aplicação.
Screens são os ecrans da aplicação.
Services são a base de dados da aplicação, eu escolhi usar uma base de dados SQLite.

Components e Screens são maioritáriamente classes com widgets que são Stateless ou StateFul, dependendo se tem conteúdo dinâmico ou estático.
Os Models ajudam a mapear os dados usados na aplicação e os dados que são recebidos da base de dados.
Os Screens ligam funcionalidades com componentes do layout.
Os Services são a base de dados SQLite, com três tabelas e métodos para aceder aos dados da base de dados.

## Objectivos atingidos
O maior objectivo atingido for completar em geral todos os componentes que tinha desenhado na wireframe e não existe nenhum bug cause um erro fatal na aplicação .
Era muito importante para mim conseguir ter a aplicação funcional que estivesse aptar a ser usada.

## Obstáculos encontrados
Foram bastantes os obstáculos encontrados, mas o maior de todos foi o uso de programação e funções assíncronas.
O Flutter tem métodos como o FutureBuilder, Future, await e asnyc, que era totalmente novos para mim e rápidamente se tornaram um grande problema.
Estive presa durante bastante tempo em algumas funcionalidades como os gráficos. 
[De tal forma que recorri ao stackoverflow para alguma ajuda a resolver o meu problema.](https://stackoverflow.com/questions/62498651/chartsthe-argument-type-futurelistserieslinearsales-int-cant-be-assig)
Eventualmente consegui resolver, e estou muito contente com o resultado.

## Considerações finais
Estou bastante contente com o resultado final da aplicação. Fui capaz de aprofundar muitos conhecimentos durante a realização do projecto, que planeio reutilizar no futuro.
Em retrospectiva em relação à aplicação gostaria de melhorar no futuro um pouco o grafismo, talvez adicionar um tuturial ao iniciar a app, mudar a tipografia e cores, adicionar mais detalhe aos gráficos e melhorar as interfaces.

