import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:flutter/material.dart';

const TextTheme customTextLightTheme = TextTheme(
//* for money amount
  titleLarge: TextStyle(color: Color(0xFF404040), fontFamily: 'OpenSansExtraBold', fontSize: 50, letterSpacing: 2),

  //* for Bonjour, white
  labelLarge: TextStyle(color: Colors.white, fontFamily: 'Montserrat-Bold', fontSize: 25, letterSpacing: 2),

  //* for Liste des magasins
  titleMedium: TextStyle(color: Color(0xFF404040), fontFamily: 'Montserrat-Bold', fontSize: 20),

  //* for all title of page -> Recherche..., Statistiques ...
  headlineMedium: TextStyle(color: Color(0xFF404040), fontFamily: 'Montserrat-Bold', fontSize: 22, letterSpacing: 1.5),

  //* for Solde, item List
  bodySmall: TextStyle(color: Color(0xFF404040), fontFamily: 'Montserrat-Bold', fontSize: 16),

  //* for price
  labelSmall: TextStyle(color: Color(0xFF404040), fontFamily: 'Montserrat-Bold', fontSize: 20),

  //* for mdp and other very small text
  displaySmall: TextStyle(color: Color(0xFF404040), fontFamily: 'Montserrat-Bold', fontSize: 12),
);

const TextTheme customTextDarkTheme = TextTheme(
  //* for money amount
  titleLarge: TextStyle(
    color: Color.fromARGB(255, 220, 220, 220),
    fontFamily: 'OpenSansExtraBold',
    fontSize: 50,
    letterSpacing: 2,
    overflow: TextOverflow.ellipsis,
  ),

  //* for Bonjour, white
  labelLarge:
      TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 25, letterSpacing: 2, overflow: TextOverflow.ellipsis),

  //* for Liste des magasins
  titleMedium: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 20, overflow: TextOverflow.ellipsis),

  //* for all title of page -> Recherche..., Statistiques ...
  headlineMedium:
      TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 22, letterSpacing: 1.5, overflow: TextOverflow.ellipsis),

  //* for Solde, item List
  bodySmall: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 16, overflow: TextOverflow.ellipsis),

  //* for price
  labelSmall: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 20, overflow: TextOverflow.ellipsis),

  //* for mdp and other very small text
  displaySmall: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 12, overflow: TextOverflow.ellipsis),
);

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: customLightTheme,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, surfaceTintColor: AppColors.cardLightColor),
    textTheme: customTextLightTheme,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackGroundColor,
    colorScheme: customDarkTheme,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkBackGroundColor, surfaceTintColor: AppColors.cardDarkColor),
    textTheme: customTextDarkTheme,
  );
}
