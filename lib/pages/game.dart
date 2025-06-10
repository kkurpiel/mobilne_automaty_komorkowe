import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/models/game_model.dart';
import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';
import 'package:mobilne_automaty_komorkowe/services/game_of_life_service.dart';
import 'package:mobilne_automaty_komorkowe/services/game_save_service.dart';
import 'package:mobilne_automaty_komorkowe/utils/snackbar_custom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/appbar_custom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/btn_bottom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/container_background.dart';
import 'package:mobilne_automaty_komorkowe/widgets/dialog_game_save.dart';
import 'package:mobilne_automaty_komorkowe/widgets/grid_rotating.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class GamePage extends StatefulWidget {
  final GameModel? gameModel;

  const GamePage({
    super.key,
    this.gameModel
  });
  
  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  /// Inicjalizacja serwisu odpowiedzialnego za zarzadzanie gra w zycie
  late GameOfLifeService gameOfLifeService = GameOfLifeService();

  /// Inicjalizacja serwisu odpowiedzialnego za zapis gry do pliku json
  late GameSaveService gameSaveService = GameSaveService();

  /// Model gry
  late GameModel game;

  /// Flaga, czy gra zostala zainicjalizowana
  bool isInitialized = false;

  /// Flaga, czy uzytkownik sprawdza wynik gry
  bool isChecking = false;

  /// Flaga, ktora strona planszy aktualnie jest wyswietlana
  bool isFrontVisible = true;

  /// Klucz pozwalajacy na dostep do stanu siatki 
  final GlobalKey<RotatingGridState> rotatingGridKey = GlobalKey<RotatingGridState>();

  /// Inicjalizacja stanu
  @override
  void initState() {
    super.initState();
    game = widget.gameModel ?? GameModel(excerciseGrid: GridModel(columns: 3, rows: 3), answerGrid: GridModel(columns: 3, rows: 3));
    if(widget.gameModel == null) {
      generateRandomUpperBoard();
    }
  }

  /// Budowanie widgetu z gra
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(title: game.name.isEmpty ? AppLocalizations.of(context)!.newGame : game.name),
      body: BackgroundContainer(
        child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CustomText(text: '${AppLocalizations.of(context)!.level}: ${game.level}.${game.sublevel}'),
                const SizedBox(height: 10),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: child.key == ValueKey<bool>(isFrontVisible) ? (isFrontVisible ? const Offset(-2.0, 0.0) : const Offset(2.0, 0.0)) : (isFrontVisible ? const Offset(2.0, 0.0) : const Offset(-2.0, 0.0)),
                      end: Offset.zero,
                    ).animate(animation);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  child: CustomText(
                    key: ValueKey<bool>(isFrontVisible),
                    text: isFrontVisible ? AppLocalizations.of(context)!.currentGeneration : AppLocalizations.of(context)!.yourPrediction,
                  ),
                ),
                Expanded(
                  child: InteractiveViewer(
                    constrained: false,
                    boundaryMargin: const EdgeInsets.all(100),
                    maxScale: 20.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                      child: RotatingGrid(
                        key: rotatingGridKey,
                        frontGrid: game.excerciseGrid,
                        backGrid: game.answerGrid,
                        cellSize: min(
                          (MediaQuery.of(context).size.width - 32) / game.excerciseGrid.columns,
                          (MediaQuery.of(context).size.height - 100) / game.excerciseGrid.rows,
                        ).floor().toDouble(),
                      ),
                    ),
                  ),
                ),
              ],
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
              RoundIconButton(
                icon: Icons.save,
                onPressed: onSavePressed,
              ),
              RoundIconButton(
                icon: Icons.sync,
                iconSize: 58,
                onPressed: () {
                  if (rotatingGridKey.currentState != null) {
                    rotatingGridKey.currentState!.flipCard();
                    setState(() {
                      isFrontVisible = rotatingGridKey.currentState!.isFrontVisible;
                    });
                  }
                },
              ),
              RoundIconButton(
                icon: Icons.check,
                onPressed: isChecking ? null : checkAnswer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Generowanie losowej planszy z gra oraz resetowanie planszy z odpowiedzia gracza
  void generateRandomUpperBoard() {
    try {
      setState(() {
        game.excerciseGrid = gameOfLifeService.generateRandomGrid(game.excerciseGrid);
      });
      clearAnswerGrid();
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

  /// Sprawdzanie odpowiedzi przez porownanie siatek z odpowiedzia gracza i z zadaniem z nastepna generacja
  /// Jezeli odpowiedz jest poprawna przejscie do nastepnego poziomu
  void checkAnswer() {
    try {
      setState(() => isChecking = true);

      final checkGrid = GridModel(
        rows: game.excerciseGrid.rows,
        columns: game.excerciseGrid.columns,
        selectedCells: game.excerciseGrid.selectedCells
          .map((row) => List<bool>.from(row))
          .toList(),
      );

      gameOfLifeService.createNextGenerationGrid(checkGrid);

      final isCorrect = gameOfLifeService.areGridsEqual(
        checkGrid.selectedCells,
        game.answerGrid.selectedCells,
      );

      if (isCorrect) {
        setState(() {
          game.sublevel++;

          if (game.sublevel >= 10) {
            game.sublevel = 0;
            game.level++;
          }

          final newSize = game.level + 2;

          game.excerciseGrid = gameOfLifeService.generateRandomGrid(
            GridModel(
              rows: newSize,
              columns: newSize,
            ),
          );

          game.answerGrid = gameOfLifeService.clearGrid(
            GridModel(
              rows: newSize,
              columns: newSize,
            ),
          );

          if (!rotatingGridKey.currentState!.isFrontVisible) {
            rotatingGridKey.currentState!.flipCard();
            isFrontVisible = true;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            AppLocalizations.of(context)!.correctAnswer
          ),
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildCustomSnackBar(
              AppLocalizations.of(context)!.wrongAnswerTryAgain,
              isError: true
            ),
          );
        });
      }
    } catch (ex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            '${AppLocalizations.of(context)!.somethingIsWrong}: $ex',
            isError: true,
          ),
        );
      });
    } finally {
      setState(() => isChecking = false);
    }
  }

  /// Resetowanie siatki z odpowiedzia gracza 
  void clearAnswerGrid() {
    try {
      setState(() {
        game.answerGrid = gameOfLifeService.clearGrid(game.answerGrid);
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

  /// Zapisywanie stanu gry
  Future<void> onSavePressed() async {
    try {
      if (game.name.isEmpty) {
        final result = await showDialog<String>(
          context: context,
          builder: (context) => SaveGameDialog(gameModel: game),
        );

        if (result == null || result.isEmpty) return;

        game.name = result;
      }
      await gameSaveService.saveGame(game);

      if (!mounted) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            AppLocalizations.of(context)!.saved,
          ),
        );
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
