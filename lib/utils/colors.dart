import 'package:flutter/material.dart';

const TextTheme customTextLightTheme = TextTheme(
//* for money amount
  titleLarge: TextStyle(color: Color(0xFF404040), fontFamily: 'OpenSansExtraBold', fontSize: 50, letterSpacing: 2),

  //* for Bonjour, white
  labelLarge: TextStyle(color: Colors.white, fontFamily: 'Montserrat-Bold', fontSize: 25, letterSpacing: 2),

  //* for Liste des magasins
  titleMedium: TextStyle(color: Color(0xFF404040), fontFamily: 'Montserrat-Bold', fontSize: 20),

  //* for all title of page -> Recherche..., Statistiques ...
  headlineMedium: TextStyle(color: Color(0xFF404040), fontFamily: 'Montserrat-Bold', fontSize: 25, letterSpacing: 1.5),

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
      TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 25, letterSpacing: 1.5, overflow: TextOverflow.ellipsis),

  //* for Solde, item List
  bodySmall: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 16, overflow: TextOverflow.ellipsis),

  //* for price
  labelSmall: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 20, overflow: TextOverflow.ellipsis),

  //* for mdp and other very small text
  displaySmall: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontFamily: 'Montserrat-Bold', fontSize: 12, overflow: TextOverflow.ellipsis),
);

final ColorScheme customLightTheme = const ColorScheme.dark().copyWith(
  primary: const Color(0xFFCD5C5C),
  secondary: const Color(0xFF012E40),
  tertiary: const Color.fromARGB(200, 1, 152, 117),
  onPrimary: const Color(0xFF404040),
  onPrimaryContainer: Colors.white,
  surface: Colors.white,
);

final ColorScheme customDarkTheme = const ColorScheme.dark().copyWith(
  primary: const Color(0xFFCD5C5C),
  secondary: const Color(0xFF012E40),
  tertiary: const Color.fromARGB(200, 1, 152, 117),
  onPrimary: const Color.fromARGB(255, 220, 220, 220),
  onPrimaryContainer: const Color(0xFF404040),
  surface: const Color.fromARGB(255, 220, 220, 220),
);

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: customLightTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    textTheme: customTextLightTheme,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackGroundColor,
    colorScheme: customDarkTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackGroundColor,
    ),
    textTheme: customTextDarkTheme,
  );
}

class AppColors {
  static const Color mainColor = Color(0xFFCD5C5C);
  static const Color secondColor = Color(0xFF012E40);
  static const Color greenEmerald = Color.fromARGB(200, 1, 152, 117);
  static const Color titleColor = Color(0xFF404040);
  static const Color greyColor = Color(0xFF8B8B8C);
  static const Color whiteGreyColor = Color.fromARGB(255, 243, 243, 243);

  static const Color darkBackGroundColor = Color(0xFF121212);
}

class ListStatColors {
  static List colorslist1 = [
    const Color(0xFF432371),
    const Color(0xFF4B2971),
    const Color(0xFF532F72),
    const Color(0xFF5B3572),
    const Color(0xFF633B73),
    const Color(0xFF6B4173),
    const Color(0xFF734774),
    const Color(0xFF7B4D74),
    const Color(0xFF835374),
    const Color(0xFF8B5975),
    const Color(0xFF935F75),
    const Color(0xFF9B6576),
    const Color(0xFFA26C76),
    const Color(0xFFAA7277),
    const Color(0xFFB27877),
    const Color(0xFFBA7E78),
    const Color(0xFFC28478),
    const Color(0xFFCA8A78),
    const Color(0xFFD29079),
    const Color(0xFFDA9679),
    const Color(0xFFE29C7A),
    const Color(0xFFEAA27A),
    const Color(0xFFF2A87B),
    const Color(0xFFE29C7A),
    const Color(0xFFFAAE7B),
  ];

  static List colorslist2 = [
    const Color(0xFF58EFEC),
    const Color(0xFF5EE9E8),
    const Color(0xFF65E2E4),
    const Color(0xFF6BDCE0),
    const Color(0xFF71D5DC),
    const Color(0xFF77CFD8),
    const Color(0xFF7EC9D4),
    const Color(0xFF84C2D0),
    const Color(0xFF8ABCCC),
    const Color(0xFF90B5C8),
    const Color(0xFF97AFC4),
    const Color(0xFF9DA9C0),
    const Color(0xFFA3A2BC),
    const Color(0xFFA99CB8),
    const Color(0xFFB096B4),
    const Color(0xFFB68FB0),
    const Color(0xFFBC89AC),
    const Color(0xFFC282A8),
    const Color(0xFFC97CA4),
    const Color(0xFFCF76A0),
    const Color(0xFFD56F9C),
    const Color(0xFFDB6998),
    const Color(0xFFE26294),
    const Color(0xFFE85C90),
  ];

  static List colorslist3 = [
    const Color(0xFF7400B8),
    const Color(0xFF740ABA),
    const Color(0xFF7415BB),
    const Color(0xFF741FBD),
    const Color(0xFF742ABE),
    const Color(0xFF7434C0),
    const Color(0xFF733EC2),
    const Color(0xFF7349C3),
    const Color(0xFF7353C5),
    const Color(0xFF735EC6),
    const Color(0xFF7368C8),
    const Color(0xFF7372CA),
    const Color(0xFF737DCB),
    const Color(0xFF7387CD),
    const Color(0xFF7391CF),
    const Color(0xFF739CD0),
    const Color(0xFF73A6D2),
    const Color(0xFF73B1D3),
    const Color(0xFF72BBD5),
    const Color(0xFF72C5D7),
    const Color(0xFF72D0D8),
    const Color(0xFF72DADA),
    const Color(0xFF72E5DB),
    const Color(0xFF72EFDD),
  ];

  static List colorslist4 = [
    const Color(0xFFBF0FFF),
    const Color(0xFFC019F7),
    const Color(0xFFC024EF),
    const Color(0xFFC12EE7),
    const Color(0xFFC139DF),
    const Color(0xFFC243D7),
    const Color(0xFFC24ED0),
    const Color(0xFFC358C8),
    const Color(0xFFC362C0),
    const Color(0xFFC46DB8),
    const Color(0xFFC477B0),
    const Color(0xFFC582A8),
    const Color(0xFFC58CA0),
    const Color(0xFFC69798),
    const Color(0xFFC6A190),
    const Color(0xFFC7AC88),
    const Color(0xFFC7B680),
    const Color(0xFFC8C078),
    const Color(0xFFC8CB71),
    const Color(0xFFC9D569),
    const Color(0xFFC9E061),
    const Color(0xFFCAEA59),
    const Color(0xFFCAF551),
    const Color(0xFFCBFF49),
  ];

  static List colorslist5 = [
    const Color(0xFFFFA585),
    const Color(0xFFFFA886),
    const Color(0xFFFFAB87),
    const Color(0xFFFFAE89),
    const Color(0xFFFFB28A),
    const Color(0xFFFFB58B),
    const Color(0xFFFFB88C),
    const Color(0xFFFFBB8D),
    const Color(0xFFFFBE8E),
    const Color(0xFFFFC190),
    const Color(0xFFFFC491),
    const Color(0xFFFFC792),
    const Color(0xFFFFCB93),
    const Color(0xFFFFCE94),
    const Color(0xFFFFD195),
    const Color(0xFFFFD497),
    const Color(0xFFFFD798),
    const Color(0xFFFFDA99),
    const Color(0xFFFFDD9A),
    const Color(0xFFFFE09B),
    const Color(0xFFFFE49C),
    const Color(0xFFFFE79E),
    const Color(0xFFFFEA9F),
    const Color(0xFFFFEDA0),
  ];

  static List colorslist6 = [
    const Color(0xFFFF4B1F),
    const Color(0xFFF55129),
    const Color(0xFFEC5832),
    const Color(0xFFE25E3C),
    const Color(0xFFD86446),
    const Color(0xFFCE6B50),
    const Color(0xFFC57159),
    const Color(0xFFBB7763),
    const Color(0xFFB17E6D),
    const Color(0xFFA78477),
    const Color(0xFF9E8A80),
    const Color(0xFF94918A),
    const Color(0xFF8A9794),
    const Color(0xFF809E9E),
    const Color(0xFF77A4A7),
    const Color(0xFF6DAAB1),
    const Color(0xFF63B1BB),
    const Color(0xFF59B7C5),
    const Color(0xFF50BDCE),
    const Color(0xFF46C4D8),
    const Color(0xFF3CCAE2),
    const Color(0xFF32D0EC),
    const Color(0xFF29D7F5),
    const Color(0xFF1FDDFF),
  ];

  static List colorslist7 = [
    const Color(0xFFBCE784),
    const Color(0xFFBFE181),
    const Color(0xFFC1DA7D),
    const Color(0xFFC4D47A),
    const Color(0xFFC7CE77),
    const Color(0xFFC9C873),
    const Color(0xFFCCC170),
    const Color(0xFFCFBB6D),
    const Color(0xFFD1B56A),
    const Color(0xFFD4AF66),
    const Color(0xFFD7A863),
    const Color(0xFFD9A260),
    const Color(0xFFDC9C5C),
    const Color(0xFFDE9659),
    const Color(0xFFE18F56),
    const Color(0xFFE48952),
    const Color(0xFFE6834F),
    const Color(0xFFE97D4C),
    const Color(0xFFEC7649),
    const Color(0xFFEE7045),
    const Color(0xFFF16A42),
    const Color(0xFFF4643F),
    const Color(0xFFF65D3B),
    const Color(0xFFF95738),
  ];

  static List colorslist8 = [
    const Color(0xFFFF6B35),
    const Color(0xFFFF703E),
    const Color(0xFFFF7447),
    const Color(0xFFFF794F),
    const Color(0xFFFF7E58),
    const Color(0xFFFF8261),
    const Color(0xFFFF876A),
    const Color(0xFFFF8C72),
    const Color(0xFFFF907B),
    const Color(0xFFFF9584),
    const Color(0xFFFF9A8D),
    const Color(0xFFFF9E96),
    const Color(0xFFFFA39E),
    const Color(0xFFFFA7A7),
    const Color(0xFFFFACB0),
    const Color(0xFFFFB1B9),
    const Color(0xFFFFB5C2),
    const Color(0xFFFFBACA),
    const Color(0xFFFFBFD3),
    const Color(0xFFFFC3DC),
    const Color(0xFFFFC8E5),
    const Color(0xFFFFCDED),
    const Color(0xFFFFD1F6),
    const Color(0xFFFFD6FF),
  ];

  static List colorslist9 = [
    const Color(0xFFBCE784),
    const Color(0xFFBEE185),
    const Color(0xFFC0DB85),
    const Color(0xFFC2D586),
    const Color(0xFFC4CF86),
    const Color(0xFFC6C987),
    const Color(0xFFC7C387),
    const Color(0xFFC9BD88),
    const Color(0xFFCBB788),
    const Color(0xFFCDB189),
    const Color(0xFFCFAB89),
    const Color(0xFFD1A58A),
    const Color(0xFFD39E8A),
    const Color(0xFFD5988B),
    const Color(0xFFD7928B),
    const Color(0xFFD98C8C),
    const Color(0xFFDB868C),
    const Color(0xFFDD808D),
    const Color(0xFFDE7A8D),
    const Color(0xFFE0748E),
    const Color(0xFFE26E8E),
    const Color(0xFFE4688F),
    const Color(0xFFE6628F),
    const Color(0xFFE85C90),
  ];

  static List colorslist10 = [
    const Color(0xFFBCE784),
    const Color(0xFFB4E088),
    const Color(0xFFADD98C),
    const Color(0xFFA5D190),
    const Color(0xFF9ECA94),
    const Color(0xFF96C398),
    const Color(0xFF8EBC9C),
    const Color(0xFF87B4A0),
    const Color(0xFF7FADA4),
    const Color(0xFF78A6A8),
    const Color(0xFF709FAC),
    const Color(0xFF6898B0),
    const Color(0xFF6190B5),
    const Color(0xFF5989B9),
    const Color(0xFF5182BD),
    const Color(0xFF4A7BC1),
    const Color(0xFF4274C5),
    const Color(0xFF3B6CC9),
    const Color(0xFF3365CD),
    const Color(0xFF2B5ED1),
    const Color(0xFF2457D5),
    const Color(0xFF1C4FD9),
    const Color(0xFF1548DD),
    const Color(0xFF0D41E1),
  ];

  static List colors12list11 = [
    const Color(0xFF432371),
    const Color(0xFF543072),
    const Color(0xFF643C73),
    const Color(0xFF754974),
    const Color(0xFF865675),
    const Color(0xFF966276),
    const Color(0xFFA76F76),
    const Color(0xFFB77B77),
    const Color(0xFFC88878),
    const Color(0xFFD99579),
    const Color(0xFFE9A17A),
    const Color(0xFFFAAE7B),
  ];

  static List colors12list12 = [
    const Color(0xFF2D00F7),
    const Color(0xFF3F00ED),
    const Color(0xFF5100E3),
    const Color(0xFF6300D9),
    const Color(0xFF7500CF),
    const Color(0xFF8700C5),
    const Color(0xFF9800BB),
    const Color(0xFFAA00B1),
    const Color(0xFFBC00A7),
    const Color(0xFFCE009D),
    const Color(0xFFE00093),
    const Color(0xFFF20089),
  ];

  static List colors12list13 = [
    const Color(0xFF9381FF),
    const Color(0xFF9D89F9),
    const Color(0xFFA791F3),
    const Color(0xFFB099ED),
    const Color(0xFFBAA1E7),
    const Color(0xFFC4A9E1),
    const Color(0xFFCEB0DC),
    const Color(0xFFD8B8D6),
    const Color(0xFFE2C0D0),
    const Color(0xFFEBC8CA),
    const Color(0xFFF5D0C4),
    const Color(0xFFFFD8BE),
  ];
  static List colors12list14 = [
    const Color(0xFFFF6B6B),
    const Color(0xFFEA696A),
    const Color(0xFFD56768),
    const Color(0xFFC16467),
    const Color(0xFFAC6266),
    const Color(0xFF976064),
    const Color(0xFF825E63),
    const Color(0xFF6D5C61),
    const Color(0xFF585A60),
    const Color(0xFF44575F),
    const Color(0xFF2F555D),
    const Color(0xFF1A535C),
  ];

  static List colors12list15 = [
    const Color(0xFFFF6B6B),
    const Color(0xFFFF766B),
    const Color(0xFFFF816B),
    const Color(0xFFFF8D6C),
    const Color(0xFFFF986C),
    const Color(0xFFFFA36C),
    const Color(0xFFFFAE6C),
    const Color(0xFFFFB96C),
    const Color(0xFFFFC46C),
    const Color(0xFFFFD06D),
    const Color(0xFFFFDB6D),
    const Color(0xFFFFE66D),
  ];

  static List colors10list16 = [
    const Color(0xFFf72585),
    const Color(0xFFb5179e),
    const Color(0xFF7209b7),
    const Color(0xFF560bad),
    const Color(0xFF480ca8),
    const Color(0xFF3a0ca3),
    const Color(0xFF3f37c9),
    const Color(0xFF4361ee),
    const Color(0xFF4895ef),
    const Color(0xFF4cc9f0),
  ];

  static List colors10list17 = [
    const Color(0xFFf94144),
    const Color(0xFFf3722c),
    const Color(0xFFf8961e),
    const Color(0xFFf9844a),
    const Color(0xFFf9c74f),
    const Color(0xFF90be6d),
    const Color(0xFF43aa8b),
    const Color(0xFF4d908e),
    const Color(0xFF577590),
    const Color(0xFF277da1),
  ];

  static List colors10list18 = [
    const Color(0xFFfbf8cc),
    const Color(0xFFfde4cf),
    const Color(0xFFffcfd2),
    const Color(0xFFf1c0e8),
    const Color(0xFFcfbaf0),
    const Color(0xFFa3c4f3),
    const Color(0xFF90dbf4),
    const Color(0xFF8eecf5),
    const Color(0xFF98f5e1),
    const Color(0xFFb9fbc0),
  ];
}
