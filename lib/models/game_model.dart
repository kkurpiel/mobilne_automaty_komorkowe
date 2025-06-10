import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';

/// Model gry posiadajacy skladajacy sie z:
/// - podstawowaych informacji na temat rozgrywki (nazwa, poziom i data),
/// - dwoch siatek (jedna z zadaniem, druga z odpowiedzia)
class GameModel {
  String name;
  GridModel excerciseGrid;
  GridModel answerGrid;
  int level;
  int sublevel;
  DateTime date;

  GameModel({
    this.name = '',
    DateTime? date,
    required this.excerciseGrid,
    required this.answerGrid,
    this.level = 1,
    this.sublevel = 0
  }) : date = date ?? DateTime.now();
}
