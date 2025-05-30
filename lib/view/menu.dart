import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/widgets/menu_button.dart';

class MenuPage extends StatelessWidget 
{
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/tlo.gif"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black12,
            BlendMode.color,
          ),
        ),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 100),
          Text(
            AppLocalizations.of(context)!.appNameFirst2,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,   
          ),
          Text(
            AppLocalizations.of(context)!.appNameThird,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          menuButton(context, AppLocalizations.of(context)!.newGame, () {
            Navigator.pushNamed(context, '/game');
          }),
          menuButton(context, AppLocalizations.of(context)!.loadGame, () {
            Navigator.pushNamed(context, '/load');
          }),
          menuButton(context, AppLocalizations.of(context)!.options, () {
            Navigator.pushNamed(context, '/options');
          }),
          menuButton(context, AppLocalizations.of(context)!.aboutCellularAutomatons, () {
            Navigator.pushNamed(context, '/about');
          }),
        ],
      ),
    ),
  );
}
