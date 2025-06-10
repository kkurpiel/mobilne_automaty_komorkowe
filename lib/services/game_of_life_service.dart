import 'dart:math';

import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';
import 'package:mobilne_automaty_komorkowe/models/simulation_model.dart';

class GameOfLifeService {
  void createNextGenerationGrid(GridModel grid) {
    final rows = grid.rows;
    final cols = grid.columns;
    final oldGrid = grid.selectedCells;
    final newGrid = List.generate(rows, (_) => List.filled(cols, false));

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        int alive = 0;
        for (int dr = -1; dr <= 1; dr++) {
          for (int dc = -1; dc <= 1; dc++) {
            if (dr == 0 && dc == 0) continue;
            final int nr = r + dr;
            final int nc = c + dc;
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
              if (oldGrid[nr][nc]) alive++;
            }
          }
        }
        if (oldGrid[r][c]) {
          newGrid[r][c] = alive == 2 || alive == 3;
        } else {
          newGrid[r][c] = alive == 3;
        }
      }
    }
    grid.selectedCells = newGrid;
  }

  void createNextGeneration(SimulationModel simulation) {
    final rows = simulation.grid.rows;
    final cols = simulation.grid.columns;
    final oldGrid = simulation.grid.selectedCells;
    final newGrid = List.generate(rows, (_) => List.filled(cols, false));
    bool hasAliveCells = false;

    simulation.simulationHistory.add(
      oldGrid.map((row) => List<bool>.from(row)).toList(),
    );

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        int alive = 0;
        for (int dr = -1; dr <= 1; dr++) {
          for (int dc = -1; dc <= 1; dc++) {
            if (dr == 0 && dc == 0) continue;
            final int nr = r + dr;
            final int nc = c + dc;
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
              if (oldGrid[nr][nc]) alive++;
            }
          }
        }
        if (oldGrid[r][c]) {
          newGrid[r][c] = alive == 2 || alive == 3;
        } else {
          newGrid[r][c] = alive == 3;
        }
        if (newGrid[r][c]) hasAliveCells = true;
      }
    }

    simulation.grid.selectedCells = newGrid;
    simulation.generationCounter++;
    simulation.hasAliveCells = hasAliveCells;
  }

  void undoGeneration(SimulationModel simulation ) {
    if (simulation.simulationHistory.isNotEmpty) {
      simulation.grid.selectedCells = simulation.simulationHistory.removeLast();
      simulation.generationCounter--;
    }
  }

  void restartSimulation(SimulationModel simulation) {
    simulation.generationCounter = 0;
    simulation.grid.selectedCells = List.generate(
      simulation.grid.rows,
      (_) => List.filled(simulation.grid.columns, false),
    );
    simulation.simulationHistory.clear();
    simulation.hasAliveCells = false;
  }

  bool areGridsEqual(List<List<bool>> a, List<List<bool>> b) {
    if (a.length != b.length) return false;

    for (int i = 0; i < a.length; i++) {
      if (a[i].length != b[i].length) return false;

      for (int j = 0; j < a[i].length; j++) {
        if (a[i][j] != b[i][j]) return false;
      }
    }
    return true;
  }

  GridModel generateRandomGrid(GridModel grid) {
    grid.selectedCells = List.generate(
      grid.rows,
      (_) => List.generate(grid.columns, (_) => Random().nextBool()),
    );
    return grid;
  }

  GridModel clearGrid(GridModel grid) {
    grid.selectedCells = List.generate(
      grid.rows,
      (_) => List.filled(grid.columns, false),
    );
    return grid;
  }
}
