import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/models/game_model.dart';
import 'package:mobilne_automaty_komorkowe/pages/game.dart';
import 'package:mobilne_automaty_komorkowe/services/game_save_service.dart';
import 'package:mobilne_automaty_komorkowe/utils/snackbar_custom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/appbar_custom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/btn_bottom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/container_background.dart';
import 'package:mobilne_automaty_komorkowe/widgets/dialog_confirm_delete.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => LoadPageState();
}

class LoadPageState extends State<LoadPage> {
  /// Inicjalizacja serwisu odpowiedzialnego za zapis gry do pliku json
  final GameSaveService gameSaveService = GameSaveService();
  
  /// Lista zapisanych gier
  late List<GameModel> savedGames = [];

  /// Set przechowujacy wybrane za pomoaca checkBoxa gry
  final Set<int> selectedGames = {};

  /// Inicjalizacja stanu
  @override
  void initState() {
    super.initState();
    loadSavedGames();
  }

  /// Budowanie widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.loadGame,
      ),
      body: BackgroundContainer(
        colorFilterColor: Colors.black54,
        child: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.transparent,
              ],
              stops: [0.0, 0.10, 0.90, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 50.0, bottom: 20.0),
            itemCount: savedGames.length,
            itemBuilder: (context, index) {
              final game = savedGames[index];
              final isSelected = selectedGames.contains(index);
              return Container(
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.green.shade600, Colors.green.shade900]),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.black54,
                    width: 3,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Colors.black54,
                      width: 3,
                    ),
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: CustomText(
                      text: game.name,
                      maxLines: 1,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: CustomText(
                    text: DateFormat('dd-MM-yyyy HH:mm:ss').format(game.date),
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GamePage(gameModel: game)),
                    );
                  },
                  trailing: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        toggleSelectedGame(index, value);
                      },
                      activeColor: Colors.green.shade900,
                      checkColor: Colors.white
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),      
      bottomNavigationBar: BottomAppBar(
        height: 120,
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RoundIconButton(
                icon: Icons.skip_previous,
                onPressed: null,
                isVisible: false
              ),
              RoundIconButton(
                icon: Icons.delete,
                iconSize: 58,
                onPressed: deleteSelectedGames,
              ),
              const RoundIconButton(
                icon: Icons.skip_previous,
                onPressed: null,
                isVisible: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Metoda pobierajaca zapisane gry z pliku
  Future<void> loadSavedGames() async {
    try {
      final games = await gameSaveService.getSavedGames();
      setState(() {
        savedGames = games;
      });
    } catch (ex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            '${AppLocalizations.of(context)!.somethingIsWrong}: $ex',
            isError: true,
          ),
        );
      });
    }
  }

  /// Metoda usuwajaca wybrane gry z pliku
  Future<void> deleteSelectedGames() async {
    try{
      if (selectedGames.isEmpty) return;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => ConfirmDeleteDialog(
            message: AppLocalizations.of(context)!.confirmDelete,
        ),
      );
      if (confirmed != true) return;

      final namesToDelete = selectedGames.map((index) => savedGames[index].name).toList();
      await gameSaveService.deleteSavedGamesByName(namesToDelete);
      await loadSavedGames();
      setState(() {
        selectedGames.clear();
      });
    } catch (ex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            '${AppLocalizations.of(context)!.somethingIsWrong}: $ex',
            isError: true,
          ),
        );
      });
    }
  }

  /// Metoda przy zmianie stanu checkBoxa, dodajaca / usuwajaca gry z listy do usuniecia 
  void toggleSelectedGame(int index, bool? isSelected) {
    try {
      setState(() {
        if (isSelected == true) {
          selectedGames.add(index);
        } else {
          selectedGames.remove(index);
        }
      });
    } catch (ex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            '${AppLocalizations.of(context)!.somethingIsWrong}: $ex',
            isError: true,
          ),
        );
      });
    }
  }
}
