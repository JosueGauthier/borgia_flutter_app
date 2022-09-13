# Borgia App

<p align="center" width="100%">
    <img src="https://user-images.githubusercontent.com/20337589/175979211-e7f35077-a3cc-4b78-8966-e3cbc05c1a4c.png" alt="logoborgia" width="50%"/>
</p>

# ![Illustration](https://user-images.githubusercontent.com/20337589/175976110-09a1718b-78cb-4316-ac4f-560b2d168a69.png)

Current Version : 1.0.x   
Licence : [GNU GPL version 3](./license.txt)

#### Here is the frontend part (Flutter) of the Borgia app project 
#### The backend part (Django) can be found [here.](https://github.com/JosueGauthier/borgia-serv)


App available on Google Play : https://play.google.com/store/apps/details?id=to.josue.borgia

    Demo username : 00An200
    Demo password : demo

Borgia is a software to help you manage your student association. 
With it, you can sell products, organize events, keep track of your stocks, etc...
It will be your best ally to develop your possibilities for your student association.




https://user-images.githubusercontent.com/20337589/189542815-bb41c4a0-f0d1-4b99-93f5-84f10f13bf68.mp4


Sales features: 

Borgia has a specific product sales system. 
First, it is necessary to recharge your Borgia balance via the Lydia application. Once your balance is credited. 

Several possibilities are available to you: 
    - Free sale: Put products in free access, based on trust, where each user registers via the application and deducts the market value of the product from his balance. 
    - Sale by operator: A responsible operator registers on the application the person buying and the product purchased. (Functionality under deployment). 

![borgiatradesysyt](https://user-images.githubusercontent.com/20337589/175981298-09230652-1a3d-4558-bda6-2598f3321de7.png)


Admin features : 

- Possibility for administrators to create, modify, delete products and categories.
- Possibility for administrators to modify existing stores.
- Possibility to set up product sales by operator (an operator with authorizations can sell a product to a user)


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

A big thank you to the Borgia team for the development of the original Borgia website: 
- Vincent Keppens
- Alexandre Palo
- Mael Lacour
- Wassim Belmezouar

And to Mael Bourreau for the illustrations. 

# Dependencies

Borgia app Flutter dependencies :

- animated_text_kit : Animated text widget
- cached_network_image : To store images inside shared_preferences
- shared_preferences: To store some informations inside user smartphone (can be deleted)
- intl: Provides internationalization facilities, plurals and genders, date/number formatting and parsing,...
- graphic: Used to create stats charts
- get: GetX is a microframework combined with route management and dependency injection. It aims to deliver top-of-the-line development experience in an extra lightweight but powerful solution for Flutter.
- fl_chart: Used to create stats charts
- percent_indicator: Percent indicator widget
- file_picker: To load asser from smartphone
- cloudinary_public: For hosting shop, coategories and product image on cloud
- loading_indicator: For custom loading_indicator
- external_app_launcher: To launch Lydia app
- url_launcher: To launch url on browser (forget password page, mail, phone, lydia page...)
- flutter_launcher_icons: To update launcher icon on app
- cupertino_icons: For icons

Borgia base dependencies :

-   Django : Borgia run with the django framework
-   django-bootstrap-form : To use bootstrap with django (Borgia web)
-   django-static-precompiler : For static files (Borgia web)
-   openpyxl : For excel manipulation
-   Pillow : For users images
-   Django Rest Framework : For REST API endpoints

