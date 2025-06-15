import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/pages/about.dart';
import 'package:mobilne_automaty_komorkowe/pages/game.dart';
import 'package:mobilne_automaty_komorkowe/pages/load.dart';
import 'package:mobilne_automaty_komorkowe/pages/menu.dart';
import 'package:mobilne_automaty_komorkowe/pages/simulation.dart';
import 'package:mobilne_automaty_komorkowe/utils/build_page_animation.dart';

void main() {
  runApp(MobilneAutomatyKomorkoweApp());
}

class MobilneAutomatyKomorkoweApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return buildPageTransition(settings, const MenuPage());
          case '/game':
            return buildPageTransition(settings, const GamePage());
          case '/load':
            return buildPageTransition(settings, const LoadPage());
          case '/simulation':
            return buildPageTransition(settings, const SimulationPage());
          case '/about': 
            return buildPageTransition(settings, const AboutPage());
        }
        return null;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
