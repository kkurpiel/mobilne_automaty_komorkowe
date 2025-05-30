import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/view/about.dart';
import 'package:mobilne_automaty_komorkowe/view/author.dart';
import 'package:mobilne_automaty_komorkowe/view/game.dart';
import 'package:mobilne_automaty_komorkowe/view/load.dart';
import 'package:mobilne_automaty_komorkowe/view/menu.dart';
import 'package:mobilne_automaty_komorkowe/view/options.dart';

void main() 
{
  runApp(const MobilneAutomatyKomorkoweApp());
}


class MobilneAutomatyKomorkoweApp extends StatelessWidget 
{
  const MobilneAutomatyKomorkoweApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    initialRoute: '/',
    routes:{
      '/': (context) => const MenuPage(),
      '/game': (context) => const GamePage(),
      '/load': (context) => const LoadPage(),
      '/options':(context) => const OptionsPage(),
      '/about': (context) => const AboutPage(),
      '/author': (context) => const AuthorPage(),
    },
    title: AppLocalizations.of(context)?.appName,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green.shade800,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Courier New',
          color: Colors.grey.shade300,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          fontFamily: 'Courier New',
          shadows: [
            Shadow(
              offset: Offset(3, 3),
              blurRadius: 5.0,
              color: Colors.black87
            )
          ]
        ),
        bodyMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Courier New',
          shadows: [
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 8.0,
              color: Colors.black54
            )
          ]
        ),
      ),
    ),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    //home: const MenuPage()
  );
}
