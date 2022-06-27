# Borgia App

<p align="center" width="100%">
    <img src="https://user-images.githubusercontent.com/20337589/175979211-e7f35077-a3cc-4b78-8966-e3cbc05c1a4c.png" alt="logoborgia" width="50%"/>
</p>

# ![Illustration](https://user-images.githubusercontent.com/20337589/175976110-09a1718b-78cb-4316-ac4f-560b2d168a69.png)


The roadmap of Borgia app : https://josue-gauthier.notion.site/Roadmap-Borgia-dd0bb947f5444ea198af76f6c90f2aee

Current Version : 1.0.x   
Licence : [GNU GPL version 3](./license.txt)

#### Here is the frontend part (Flutter) of the Borgia app project 
#### The backend part (Django) can be found [here.](https://github.com/JosueGauthier/borgia-serv)


Borgia is a software to help you manage your student association. 
With it, you can sell products, organize events, keep track of your stocks, etc...
It will be your best ally to develop your possibilities for your student association.

https://user-images.githubusercontent.com/20337589/175973686-dc7cb745-832b-4948-a60f-bd0ca4d71bc5.mp4
Sales features: 

Borgia has a specific product sales system. 
First, it is necessary to recharge your Borgia balance via the Lydia application. Once your balance is credited. 

Several possibilities are available to you: 
    - Free sale: Put products in free access, based on trust, where each user registers via the application and deducts the market value of the product from his balance. 
    - Sale by operator: A responsible operator registers on the application the person buying and the product purchased. (Functionality under deployment). 

![borgiatradesysyt](https://user-images.githubusercontent.com/20337589/175981298-09230652-1a3d-4558-bda6-2598f3321de7.png)


but also : 

- A global statistics panel is available with the sales for the whole association
- A panel of statistics of the user's purchases is also available. 
- A podium system by store and by product has been added.
- A list of favorites is available taking into account the most purchased products.
- A list of the last purchases made in the application. 
- A search system allowing to search users, products, stores, ...


# Installation

This flutter app works with Django Borgia backend who can be found [here.](https://github.com/JosueGauthier/borgia-serv)

You first need to install a production or developpement server to use this app.

###### Do not use Borgia-app original repository, no endpoints are configured.


# Documentation

Documentation are currently in writing-phase. Some ressources are available
[here](https://github.com/borgia-app/Borgia-docs).


# Acknowledgements

A big thank you to the Borgia team for the development of the original Borgia application: 
- Vincent Keppens
- Alexandre Palo
- Mael Lacour
- Wassim Belmezouar

And to Mael Bourreau for the illustrations. 

# Dependency

Borgia base dependency :

-   Django : Borgia run with the django framework
-   django-bootstrap-form : To use bootstrap with django
-   django-static-precompiler : For static files
-   openpyxl : For excel manipulation
-   Pillow : For users images

