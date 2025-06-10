import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/widgets/btn_menu.dart';
import 'package:mobilne_automaty_komorkowe/widgets/container_background.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  /// Budowanie widoku menu gry
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        colorFilterColor: Colors.black12,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              CustomText(
                text: AppLocalizations.of(context)!.appNameFirst2,
                fontSize: 36,
                textAlign: TextAlign.center,   
              ),
              CustomText(
                text: AppLocalizations.of(context)!.appNameThird,
                fontSize: 36,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 50),
                    MenuButton(text: AppLocalizations.of(context)!.newGame, route: '/game'),
                    MenuButton(text: AppLocalizations.of(context)!.loadGame, route: '/load'),
                    MenuButton(text: AppLocalizations.of(context)!.simulation, route: '/simulation'),
                    MenuButton(text: AppLocalizations.of(context)!.aboutCellularAutomatons, route: '/about'),
                  ],
                ),
              ),
            ],
          ),  
        ),
      )
    );
  }
}
