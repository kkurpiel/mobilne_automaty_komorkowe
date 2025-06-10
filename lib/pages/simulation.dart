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
  late GameOfLifeService gameOfLifeService = GameOfLifeService();
  late SimulationModel simulation = SimulationModel(
    grid: GridModel(columns: 20, rows: 20),
    fps: 3,
    hasAliveCells: false,
  );

  Timer? timer;
  bool isGridEditable = false;
  bool isGameRunning = false;
  late int pixelsPerCell = 10;

  final GlobalKey<SelectableGridState> gridKey = GlobalKey<SelectableGridState>();

  @override
  void initState() {
    super.initState();
    initializeSimulation();
  }

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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void pauseGame() {
    timer?.cancel();
    setState(() {
      isGameRunning = false;
    });
  }

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
