import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Mobile Cellular Automaton'**
  String get appName;

  /// No description provided for @appNameFirst2.
  ///
  /// In en, this message translates to:
  /// **'Mobile Cellular'**
  String get appNameFirst2;

  /// No description provided for @appNameThird.
  ///
  /// In en, this message translates to:
  /// **'Automaton'**
  String get appNameThird;

  /// No description provided for @simulation.
  ///
  /// In en, this message translates to:
  /// **'Simulation'**
  String get simulation;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// No description provided for @loadGame.
  ///
  /// In en, this message translates to:
  /// **'Load Game'**
  String get loadGame;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @aboutCellularAutomatons.
  ///
  /// In en, this message translates to:
  /// **'About Automatons'**
  String get aboutCellularAutomatons;

  /// No description provided for @whatIsCellularAutomatonTopic.
  ///
  /// In en, this message translates to:
  /// **'What\'s a cellular automaton?'**
  String get whatIsCellularAutomatonTopic;

  /// No description provided for @whatIsCellularAutomatonContent.
  ///
  /// In en, this message translates to:
  /// **'Cellular automata are mathematical models consisting of a grid of cells, each in one of a limited number of states.\n Time in such systems is discrete – at each step, cells change their state based on fixed rules and the states of neighboring cells.\n Despite their simplicity, cellular automata can lead to highly complex behaviors. They are often used to study emergence – phenomena where complex system behavior arises from simple local rules.'**
  String get whatIsCellularAutomatonContent;

  /// No description provided for @whatIsCellularAutomatonLearnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get whatIsCellularAutomatonLearnMore;

  /// No description provided for @whatIsCellularAutomatonUrl.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Cellular_automaton'**
  String get whatIsCellularAutomatonUrl;

  /// No description provided for @usageAndMeaningTopic.
  ///
  /// In en, this message translates to:
  /// **'Usage and meaning'**
  String get usageAndMeaningTopic;

  /// No description provided for @usageAndMeaningContent.
  ///
  /// In en, this message translates to:
  /// **'Cellular automata are used in many scientific fields, such as physics, biology, computer science, and chemistry.\n They serve to model natural phenomena, like the spread of fire, population growth, crystallization, or even information flow in networks.\n Studying them helps us understand how global patterns and complex systems can emerge from local rules. They are increasingly applied in artificial intelligence, urban simulations, and designing nature-inspired algorithms.'**
  String get usageAndMeaningContent;

  /// No description provided for @usageAndMeaningLearnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get usageAndMeaningLearnMore;

  /// No description provided for @usageAndMeaningUrl.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Cellular_automaton'**
  String get usageAndMeaningUrl;

  /// No description provided for @conwaysGameOfLifeTopic.
  ///
  /// In en, this message translates to:
  /// **'Conway\'s Game of Life'**
  String get conwaysGameOfLifeTopic;

  /// No description provided for @conwaysGameOfLifeContent.
  ///
  /// In en, this message translates to:
  /// **'The most well-known example of a cellular automaton is the Game of Life, created by John Conway in 1970.\n It operates on a two-dimensional grid where each cell is either “alive” or “dead.” The rules determine the birth, survival, or death of a cell based on the number of its neighbors.\n Although the rules are simple, the game produces surprising patterns – from stable structures to objects that move or replicate.\n The Game of Life has inspired scientists and artists alike, demonstrating how order can emerge from apparent chaos.'**
  String get conwaysGameOfLifeContent;

  /// No description provided for @conwaysGameOfLifeLearnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get conwaysGameOfLifeLearnMore;

  /// No description provided for @conwaysGameOfLifeUrl.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life'**
  String get conwaysGameOfLifeUrl;

  /// No description provided for @cantOpenUrl.
  ///
  /// In en, this message translates to:
  /// **'Can\'t open URL.'**
  String get cantOpenUrl;

  /// No description provided for @columns.
  ///
  /// In en, this message translates to:
  /// **'columns'**
  String get columns;

  /// No description provided for @rows.
  ///
  /// In en, this message translates to:
  /// **'rows'**
  String get rows;

  /// No description provided for @fps.
  ///
  /// In en, this message translates to:
  /// **'fps'**
  String get fps;

  /// No description provided for @generation.
  ///
  /// In en, this message translates to:
  /// **'Generation'**
  String get generation;

  /// No description provided for @noMoreAliveCells.
  ///
  /// In en, this message translates to:
  /// **'The simulation is finished. No more living cells'**
  String get noMoreAliveCells;

  /// No description provided for @gridSameAsPrevious.
  ///
  /// In en, this message translates to:
  /// **'The simulation has been looped'**
  String get gridSameAsPrevious;

  /// No description provided for @currentGeneration.
  ///
  /// In en, this message translates to:
  /// **'Current Generation'**
  String get currentGeneration;

  /// No description provided for @yourPrediction.
  ///
  /// In en, this message translates to:
  /// **'Your Prediction'**
  String get yourPrediction;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @correctAnswer.
  ///
  /// In en, this message translates to:
  /// **'Correct! Next level...'**
  String get correctAnswer;

  /// No description provided for @wrongAnswerTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Wrong answer. Try again.'**
  String get wrongAnswerTryAgain;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @nameOfTheGame.
  ///
  /// In en, this message translates to:
  /// **'Name of the game'**
  String get nameOfTheGame;

  /// No description provided for @nameOfTheGameEg.
  ///
  /// In en, this message translates to:
  /// **'e.g. My game'**
  String get nameOfTheGameEg;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @selectSavedGames.
  ///
  /// In en, this message translates to:
  /// **'Select saved games'**
  String get selectSavedGames;

  /// No description provided for @somethingIsWrong.
  ///
  /// In en, this message translates to:
  /// **'Something is wrong'**
  String get somethingIsWrong;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete selected games?'**
  String get confirmDelete;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
