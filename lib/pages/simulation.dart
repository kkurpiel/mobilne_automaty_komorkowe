import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';
import 'package:mobilne_automaty_komorkowe/models/simulation_model.dart';
import 'package:mobilne_automaty_komorkowe/services/game_of_life_service.dart';
import 'package:mobilne_automaty_komorkowe/utils/snackbar_custom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/appbar_custom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/btn_bottom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/container_background.dart';
import 'package:mobilne_automaty_komorkowe/widgets/dialog_simulation_finished.dart';
import 'package:mobilne_automaty_komorkowe/widgets/dialog_simulation_params.dart';
import 'package:mobilne_automaty_komorkowe/widgets/grid_selectable.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({super.key});
  
  @override
  State<SimulationPage> createState() => SimulationPageState();
}

class SimulationPageState extends State<SimulationPage> {
  /// Inicjalizacja serwisu odpowiedzialnego za zarzadzanie gra w zycie
  late GameOfLifeService gameOfLifeService = GameOfLifeService();

  /// Inicjalizacja modelu symulacji domyslnymi wartosciami
  late SimulationModel simulation = SimulationModel(
    grid: GridModel(columns: 20, rows: 20),
    fps: 3,
    hasAliveCells: false,
  );

  /// Timer odpowiedzialny za przechodzenie przez kolejne generacje w okreslonym czasie
  Timer? timer;

  /// Flaga okreslajaca, czy plansza jest edytowalna
  bool isGridEditable = false;

  /// Flaga okreslajaca, czy gra jest w trybie automatycznym
  bool isGameRunning = false;

  /// Ilosc pikseli na komorke, inicjalizowana z wartoscia 10 
  /// (wartosc faktyczna zostaje obliczona na podstawie ustawionych przez uzytkownika wartosci)
  late int pixelsPerCell = 10;

  /// Klucz globalny planszy
  final GlobalKey<SelectableGridState> gridKey = GlobalKey<SelectableGridState>();

  /// Inicjalizacja stanu
  @override
  void initState() {
    super.initState();
    initializeSimulation();
  }

  /// Budowanie widgetu
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: CustomAppBar(
            title: AppLocalizations.of(context)!.simulation,
          ),
          body: BackgroundContainer(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: simulation.generationCounter > 0 ? '${AppLocalizations.of(context)!.generation}: ${simulation.generationCounter}' : '',
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black87,
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            width: (simulation.grid.columns * pixelsPerCell).toDouble(),
                            height: (simulation.grid.rows * pixelsPerCell).toDouble(),
                            child: SelectableGrid(
                              key: gridKey,
                              gridModel: simulation.grid,
                              cellSize: pixelsPerCell.toDouble(),
                              isEditable: isGridEditable,
                            ),
                          ),
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
                    icon: Icons.skip_previous,
                    onPressed: !isGridEditable
                      ? () {
                        if (isGameRunning) pauseGame();
                          undoGeneration();
                        }
                      : null,
                  ),
                  RoundIconButton(
                    icon: isGameRunning ? Icons.pause : Icons.play_arrow,
                    iconSize: 58,
                    onPressed: () {
                      if (isGameRunning) {
                        pauseGame();
                      } else {
                        startGame();
                      }
                    },
                  ),
                  RoundIconButton(
                    icon: Icons.skip_next,
                    onPressed: createNextGeneration,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }

  /// Zwolnienie zasobow i przerwanie dzialania timera
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  /// Zatrzymanie symulacji
  void pauseGame() {
    timer?.cancel();
    setState(() {
      isGameRunning = false;
    });
  }

  /// Inicjalizacja symulacji, uzytkownik wybiera rozmiar planszy i ilosc generacji na sekunde.
  /// Jezeli uzytkownik kliknie poza wyswietlony dialog zostanie przeniesiony do menu
  Future<void> initializeSimulation() async {
    try {
      await Future.delayed(Duration.zero);
      if (!mounted) return;

      final result = await showDialog<SimulationModel>(
        context: context,
        builder: (context) => const SimulationParamsContent(),
      );

      if (!mounted) return;

      if (result == null) {
        Navigator.of(context).pushReplacementNamed('/');
        return;
      }

      if (mounted) {
        setState(() {
          simulation = result;

          pixelsPerCell = min(
            MediaQuery.of(context).size.width / simulation.grid.columns,
            MediaQuery.of(context).size.height / simulation.grid.rows,
          ).floor();

          isGridEditable = true;
          simulation.grid.selectedCells = List.generate(
            simulation.grid.rows,
            (_) => List.filled(simulation.grid.columns, false),
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
    }
  }

  /// Rozpoczecie gry, ustawienie wartosci odswiezania symulacji
  /// Sprawdzenie, czy powstala generacja posiada zywe komorki oraz czy nie jest taka sama jak poprzednia 
  void startGame() {
    try {
      final delay = Duration(milliseconds: (1000 / simulation.fps).round());

      timer = Timer.periodic(delay, (_) {
        setState(() {
          gameOfLifeService.createNextGeneration(simulation);
          isGameRunning = true;
          isGridEditable = false;
        });

        if (!simulation.hasAliveCells) {
          pauseGame();
          showDialog(
            context: context,
              builder: (context) => NoMoreAliveCellsDialog(
              message: AppLocalizations.of(context)!.noMoreAliveCells,
              restartSimulation: restartSimulation,
            ),
          );
          return;
        }

        if(simulation.simulationHistory.length > 1 && gameOfLifeService.areGridsEqual(simulation.grid.selectedCells, simulation.simulationHistory[simulation.simulationHistory.length-2]) || 
           simulation.simulationHistory.isNotEmpty && gameOfLifeService.areGridsEqual(simulation.grid.selectedCells, simulation.simulationHistory.last)) {
          pauseGame();
          showDialog(
            context: context,
            builder: (context) => NoMoreAliveCellsDialog(
              message: AppLocalizations.of(context)!.gridSameAsPrevious,
              restartSimulation: restartSimulation,
            ),
          );
          return;
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

  /// Tworzenie nowej generacji.
  /// Sprawdzenie, czy stoworzona generacja posiada zywe komorki oraz czy gra nie zostala zapetlona
  /// Podczas sprawdzania zapetlenia sprawdzane jest, czy nowo wygenerowana generacja nie jest taka sama jak ostatnie dwie generacje
  void createNextGeneration() {
    try {
      setState(() {
        gameOfLifeService.createNextGeneration(simulation);
        isGridEditable = false;
      });

      if (!simulation.hasAliveCells) {
        pauseGame();
        showDialog(
          context: context,
          builder: (context) => NoMoreAliveCellsDialog(
            message: AppLocalizations.of(context)!.noMoreAliveCells,
            restartSimulation: restartSimulation,
          ),
        ); 
        return;
      }

      if(simulation.simulationHistory.length > 1 && gameOfLifeService.areGridsEqual(simulation.grid.selectedCells, simulation.simulationHistory[simulation.simulationHistory.length-2]) || 
         simulation.simulationHistory.isNotEmpty && gameOfLifeService.areGridsEqual(simulation.grid.selectedCells, simulation.simulationHistory.last)) {
        pauseGame();
        showDialog(
          context: context,
          builder: (context) => NoMoreAliveCellsDialog(
            message: AppLocalizations.of(context)!.gridSameAsPrevious,
            restartSimulation: restartSimulation,
          ),
        );
        return;
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
    }
  }

  /// Cofniecie generacji
  void undoGeneration() {
    try {
      setState(() {
        gameOfLifeService.undoGeneration(simulation);
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

  /// Restart symulacji, uzytkownik od nowa moze zaznaczyc komorki
  void restartSimulation() {
    try {
      timer?.cancel();
      setState(() {
        gameOfLifeService.restartSimulation(simulation);
        isGameRunning = false;
        isGridEditable = true;
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
