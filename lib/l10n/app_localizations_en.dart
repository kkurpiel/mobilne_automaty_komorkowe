// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Mobile Cellular Automaton';

  @override
  String get appNameFirst2 => 'Mobile Cellular';

  @override
  String get appNameThird => 'Automaton';

  @override
  String get simulation => 'Simulation';

  @override
  String get newGame => 'New Game';

  @override
  String get loadGame => 'Load Game';

  @override
  String get options => 'Options';

  @override
  String get author => 'Author';

  @override
  String get aboutCellularAutomatons => 'About Automatons';

  @override
  String get whatIsCellularAutomatonTopic => 'What\'s a cellular automaton?';

  @override
  String get whatIsCellularAutomatonContent => 'Cellular automata are mathematical models consisting of a grid of cells, each in one of a limited number of states.\n Time in such systems is discrete – at each step, cells change their state based on fixed rules and the states of neighboring cells.\n Despite their simplicity, cellular automata can lead to highly complex behaviors. They are often used to study emergence – phenomena where complex system behavior arises from simple local rules.';

  @override
  String get whatIsCellularAutomatonLearnMore => 'Learn more';

  @override
  String get whatIsCellularAutomatonUrl => 'https://en.wikipedia.org/wiki/Cellular_automaton';

  @override
  String get usageAndMeaningTopic => 'Usage and meaning';

  @override
  String get usageAndMeaningContent => 'Cellular automata are used in many scientific fields, such as physics, biology, computer science, and chemistry.\n They serve to model natural phenomena, like the spread of fire, population growth, crystallization, or even information flow in networks.\n Studying them helps us understand how global patterns and complex systems can emerge from local rules. They are increasingly applied in artificial intelligence, urban simulations, and designing nature-inspired algorithms.';

  @override
  String get usageAndMeaningLearnMore => 'Learn more';

  @override
  String get usageAndMeaningUrl => 'https://en.wikipedia.org/wiki/Cellular_automaton';

  @override
  String get conwaysGameOfLifeTopic => 'Conway\'s Game of Life';

  @override
  String get conwaysGameOfLifeContent => 'The most well-known example of a cellular automaton is the Game of Life, created by John Conway in 1970.\n It operates on a two-dimensional grid where each cell is either “alive” or “dead.” The rules determine the birth, survival, or death of a cell based on the number of its neighbors.\n Although the rules are simple, the game produces surprising patterns – from stable structures to objects that move or replicate.\n The Game of Life has inspired scientists and artists alike, demonstrating how order can emerge from apparent chaos.';

  @override
  String get conwaysGameOfLifeLearnMore => 'Learn more';

  @override
  String get conwaysGameOfLifeUrl => 'https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life';

  @override
  String get cantOpenUrl => 'Can\'t open URL.';

  @override
  String get columns => 'columns';

  @override
  String get rows => 'rows';

  @override
  String get fps => 'fps';

  @override
  String get generation => 'Generation';

  @override
  String get noMoreAliveCells => 'The simulation is finished. No more living cells';

  @override
  String get gridSameAsPrevious => 'The simulation has been looped';

  @override
  String get currentGeneration => 'Current Generation';

  @override
  String get yourPrediction => 'Your Prediction';

  @override
  String get submit => 'Submit';

  @override
  String get correctAnswer => 'Correct! Next level...';

  @override
  String get wrongAnswerTryAgain => 'Wrong answer. Try again.';

  @override
  String get level => 'Level';

  @override
  String get error => 'Error';

  @override
  String get saved => 'Saved';

  @override
  String get save => 'Save';

  @override
  String get nameOfTheGame => 'Name of the game';

  @override
  String get nameOfTheGameEg => 'e.g. My game';

  @override
  String get delete => 'Delete';

  @override
  String get selectSavedGames => 'Select saved games';

  @override
  String get somethingIsWrong => 'Something is wrong';

  @override
  String get confirmDelete => 'Do you really want to delete selected games?';
}
