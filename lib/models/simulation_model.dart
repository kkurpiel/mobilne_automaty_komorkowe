import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';

/// Model symulacji posiada dane na temat stanu symulacji.
/// Jezeli do historii nie zostanie przypisana lista poprzednicgh krokow to model inicjuje pusta liste 
class SimulationModel {
  GridModel grid;
  int fps;
  int generationCounter;
  bool hasAliveCells;
  late List<List<List<bool>>> simulationHistory;

  SimulationModel({
    required this.grid,
    required this.fps,
    required this.hasAliveCells,
    List<List<List<bool>>>? simulationHistory,
    this.generationCounter = 0
  }): simulationHistory = simulationHistory ?? [];
}
