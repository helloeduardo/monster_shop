# <div align="center">  Monster Shop

![Name of image](https://image.shutterstock.com/image-vector/cartoon-furry-monster-halloween-vector-260nw-1197171505.jpg)

## Description
"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will be able to get "shipped" by an admin. Each user role will have access to some or all CRUD functionality for application models. Additionally, Merchants can add many bulk discount rates for all of their inventory. These apply automatically in the shopping cart, and adjust the order_items price upon checkout.

## Schema
![Schema](https://user-images.githubusercontent.com/56360157/98730018-f0dc5d80-2358-11eb-9af9-b190c7ab99d8.png)

## Technology
   ![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)    ![](https://img.shields.io/badge/Code-HTML-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Code-CSS-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)

## Instructions
This application is hosted on [Heroku](https://turing-monster-shop.herokuapp.com), where you'll be able to view its functionality to the fullest.

For usage on your local machine follow the instructions listed below:
```
git clone git@github.com:helloeduardo/monster_shop.git
cd monster_shop
bundle install
rake db:{drop,create,migrate,seed}
rails server
```
Now, navigate to `http://localhost:3000/` on your browser to view the application!
