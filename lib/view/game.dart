import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_processing/flutter_processing.dart';
import 'package:mobilne_automaty_komorkowe/models/game_start_params_model.dart';
import 'package:mobilne_automaty_komorkowe/widgets/game_start_params_dialog.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  
  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  late GameStartParamsModel gameStartParamsModel = GameStartParamsModel(
    rows: 20,
    columns: 20,
    fps: 3
  );
  bool showGame = false;
  late int pixelsPerCell;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await gameStartParamsDialog(
        context: context,
        gameStartParamsModel: gameStartParamsModel,
        onStart: (calculatedPixels) {
          if(!mounted) return;
          setState(() {
            pixelsPerCell = calculatedPixels;
            showGame = true;
          });
        },
      );
    });
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    body: showGame ? Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/tlo.gif"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
          Colors.black87,
            BlendMode.darken,
          ),
        ),
      ),
      child: Processing(
        sketch: GameOfLifeSketch(
          cols: gameStartParamsModel.columns,
          rows: gameStartParamsModel.rows,
          fps: gameStartParamsModel.fps,
          pixelsPerCell: pixelsPerCell.toDouble(),
        ),
      ),
    )
    : Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/tlo.gif"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
          Colors.black45,
            BlendMode.darken,
          ),
        ),
      ),
      child:const Center(child: CircularProgressIndicator()),
    ),
  );
}



class GameOfLifeSketch extends Sketch {
  final int cols;
  final int rows;
  final int fps;
  final double pixelsPerCell;

  late List<List<bool>> grid;

  GameOfLifeSketch({
    required this.cols,
    required this.rows,
    required this.fps,
    this.pixelsPerCell = 0
  });

  @override
  Future<void> setup() async {
    size(width: (cols * pixelsPerCell).toInt(), height: (rows * pixelsPerCell).toInt());
    grid = List.generate(cols, (_) => List.generate(rows, (_) => Random().nextBool()));
    frameRate = fps;
  }

  @override
  Future<void> draw() async {
    background(color: Colors.black);
    fill(color: Colors.green.shade800);

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        if (grid[col][row]) {
          final topLeft = Offset(col * pixelsPerCell, row * pixelsPerCell);
          rect(rect: Rect.fromLTWH(topLeft.dx, topLeft.dy, pixelsPerCell, pixelsPerCell));
        }
      }
    }
    createNextGeneration();
  }

  void createNextGeneration() {
    final newGrid = List.generate(cols, (_) => List.generate(rows, (_) => false));
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        newGrid[col][row] = calculateNextCellValue(col: col, row: row);
      }
    }
    grid = newGrid;
  }

  bool calculateNextCellValue({required int col, required int row}) {
    int count = 0;

    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;

        final int nc = col + dx;
        final int nr = row + dy;

        if (nc >= 0 && nc < cols && nr >= 0 && nr < rows && grid[nc][nr]) {
          count++;
        }
      }
    }

    if (grid[col][row] && (count == 2 || count == 3)) return true;
    if (!grid[col][row] && count == 3) return true;
    return false;
  }
}
