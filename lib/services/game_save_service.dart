import 'dart:convert';
import 'dart:io';

import 'package:mobilne_automaty_komorkowe/models/game_model.dart';
import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';
import 'package:path_provider/path_provider.dart';

class GameSaveService {
  Future<void> checkSavingFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/savedGames.json');

     if (!(await file.exists())) {
      await file.create();
      await file.writeAsString('[]');
    }
  }

  Future<void> saveGame(GameModel game) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/savedGames.json');

    List<dynamic> gamesList = [];

    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.isNotEmpty) {
        gamesList = jsonDecode(content) as List<dynamic>;
      }
    }

    final newGameJson = toJson(game);

    final existingIndex = gamesList.indexWhere((g) => (g as Map<String, dynamic>)['name'] == game.name);

    if (existingIndex == -1) {
      gamesList.add(newGameJson);
    } else {
      gamesList[existingIndex] = newGameJson;
    }

    final encoded = jsonEncode(gamesList);
    await file.writeAsString(encoded);
  }
  
  Future<List<GameModel>> getSavedGames() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/savedGames.json');

    final content = await file.readAsString();
    final List<dynamic> gamesList = jsonDecode(content) as List<dynamic>;

    return gamesList.map((json) => fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<void> deleteSavedGamesByName(List<String> names) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/savedGames.json');

    if (!await file.exists()) return;

    final content = await file.readAsString();
    if (content.isEmpty) return;

    final List<dynamic> gamesList = jsonDecode(content) as List<dynamic>;
    gamesList.removeWhere((dynamic game) => names.contains((game as Map<String, dynamic>)['name']));

    final encoded = jsonEncode(gamesList);
    await file.writeAsString(encoded);
  }

  Map<String, dynamic> toJson(GameModel game) {
    return {
      'name': game.name,
      'level': game.level,
      'sublevel': game.sublevel,
      'date' : game.date.toIso8601String(),
      'excercise': {
        'rows': game.excerciseGrid.rows,
        'columns': game.excerciseGrid.columns,
        'selectedCells': game.excerciseGrid.selectedCells,
      },
      'answer': {
        'rows': game.answerGrid.rows,
        'columns': game.answerGrid.columns,
        'selectedCells': game.answerGrid.selectedCells,
      }
    };
  }

  GameModel fromJson(Map<String, dynamic> json) {
    final excerciseJson = json['excercise'] as Map<String, dynamic>;
    final answerJson = json['answer'] as Map<String, dynamic>;

    return GameModel(
      name: json['name'] as String,
      level: json['level'] as int,
      sublevel: json['sublevel'] as int,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : DateTime.now(),
      excerciseGrid: GridModel(
        columns: excerciseJson['columns'] as int, 
        rows: excerciseJson['rows'] as int,
        selectedCells: parseSelectedCells(excerciseJson),
      ),
      answerGrid: GridModel(
        columns: answerJson['columns'] as int, 
        rows: answerJson['rows'] as int,
        selectedCells: parseSelectedCells(answerJson),
      ),
    );
  }

  List<List<bool>> parseSelectedCells(Map<String, dynamic> gridJson) {
    final rawSelectedCells = gridJson['selectedCells'] as List<dynamic>;
    return rawSelectedCells.map((row) {
      return (row as List<dynamic>).map((cell) => cell as bool).toList();
    }).toList();
  }
}
