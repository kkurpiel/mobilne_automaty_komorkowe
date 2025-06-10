// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appName => 'Mobilne Automaty Komórkowe';

  @override
  String get appNameFirst2 => 'Mobilne Automaty';

  @override
  String get appNameThird => 'Komórkowe';

  @override
  String get simulation => 'Symulacja';

  @override
  String get newGame => 'Nowa Gra';

  @override
  String get loadGame => 'Wczytaj Grę';

  @override
  String get options => 'Ustawienia';

  @override
  String get author => 'Autor';

  @override
  String get aboutCellularAutomatons => 'O Automatach';

  @override
  String get whatIsCellularAutomatonTopic => 'Czym jest automat komórkowy?';

  @override
  String get whatIsCellularAutomatonContent => 'Automaty komórkowe to matematyczne modele złożone z siatki komórek, z których każda znajduje się w jednym z ograniczonego zbioru stanów.\n Czas w takim systemie jest dyskretny – w każdej turze komórki zmieniają swój stan na podstawie ustalonych reguł i stanów sąsiednich komórek.\n Pomimo prostoty, automaty komórkowe mogą prowadzić do bardzo złożonego zachowania. Są one często wykorzystywane do badania emergencji – zjawisk, w których z prostych lokalnych zasad wyłania się złożone zachowanie systemu.';

  @override
  String get whatIsCellularAutomatonLearnMore => 'Dowiedz się więcej';

  @override
  String get whatIsCellularAutomatonUrl => 'https://pl.wikipedia.org/wiki/Automat_kom%C3%B3rkowy';

  @override
  String get usageAndMeaningTopic => 'Zastosowanie i znaczenie';

  @override
  String get usageAndMeaningContent => 'Automaty komórkowe to fascynujące matematyczne modele, które symulują systemy złożone, wychodząc od niezwykle prostych założeń. Wyobraź sobie siatkę, na przykład dwuwymiarową, składającą się z niezliczonych komórek. Każda z tych komórek nie jest bynajmniej skomplikowanym bytem – wręcz przeciwnie, może przyjmować zaledwie jeden z ograniczonego zestawu stanów, na przykład \"żywy\" lub \"martwy\", \"czarny\" lub \"biały\". To właśnie ta prostota na poziomie pojedynczej komórki jest kluczem do ich niezwykłości.\n\nCzas w systemie automatów komórkowych jest dyskretny, co oznacza, że rozwija się w z góry określonych \"turach\" lub \"krokach czasowych\". W każdej takiej turze, każda komórka jednocześnie aktualizuje swój stan. Ale na jakiej podstawie? Otóż zmiany te zachodzą na podstawie ściśle określonych reguł oraz, co najważniejsze, stanów sąsiednich komórek. Reguły te są zazwyczaj bardzo proste – na przykład: \"jeśli żywa komórka ma mniej niż dwóch żywych sąsiadów, umiera z samotności\" lub \"jeśli martwa komórka ma dokładnie trzech żywych sąsiadów, ożywa\".\n\nOd Prostoty do Złożoności: Zjawisko Emergencji\n\nTo, co czyni automaty komórkowe tak intrygującymi, to fakt, że pomimo banalnej prostoty poszczególnych reguł lokalnych, system jako całość może generować niezwykle złożone i często nieprzewidywalne zachowania. Z prostych interakcji między komórkami wyłaniają się zjawiska emergencji – wzory, struktury, a nawet formy \"życia\", które nie są bezpośrednio zaprogramowane w pojedynczej regule, lecz powstają jako wypadkowa milionów lokalnych interakcji.\n\nDzięki tej właściwości, automaty komórkowe są niezastąpionym narzędziem do badania emergencji w wielu dziedzinach. Od biologii, gdzie symulują wzrost organizmów czy rozprzestrzenianie się epidemii, przez fizykę, gdzie modelują zjawiska fazowe, po informatykę, gdzie stanowią podstawę dla niektórych algorytmów. Pokazują, jak skomplikowane globalne zachowanie może narodzić się z prostych lokalnych zasad, dając wgląd w mechanizmy, które rządzą zarówno naturą, jak i złożonymi systemami stworzonymi przez człowieka.';

  @override
  String get usageAndMeaningLearnMore => 'Dowiedz się więcej';

  @override
  String get usageAndMeaningUrl => 'https://pl.wikipedia.org/wiki/Automat_kom%C3%B3rkowy';

  @override
  String get conwaysGameOfLifeTopic => 'Gra w życie Conway\'a';

  @override
  String get conwaysGameOfLifeContent => 'Najbardziej znanym przykładem automatu komórkowego jest Gra w życie stworzona przez Johna Conwaya w 1970 roku.\n Działa na siatce dwuwymiarowej, gdzie każda komórka jest „żywa” lub „martwa”. Reguły określają narodziny, przeżycie lub śmierć komórki na podstawie liczby sąsiadów.\n Mimo prostych zasad, gra prowadzi do zaskakujących wzorców – od stabilnych struktur po obiekty, które się poruszają lub rozmnażają.\n Gra w życie zainspirowała wielu badaczy i artystów, pokazując, jak z chaosu może wyłonić się porządek.';

  @override
  String get conwaysGameOfLifeLearnMore => 'Dowiedz się więcej';

  @override
  String get conwaysGameOfLifeUrl => 'https://pl.wikipedia.org/wiki/Gra_w_%C5%BCycie';

  @override
  String get cantOpenUrl => 'Nie można otworzyć URL.';

  @override
  String get columns => 'kolumny';

  @override
  String get rows => 'wiersze';

  @override
  String get fps => 'klatki na sekundę';

  @override
  String get generation => 'Generacja';

  @override
  String get noMoreAliveCells => 'Symulacja została zakończona. Brak żyjących komórek';

  @override
  String get gridSameAsPrevious => 'Symulacja została zapętlona.';

  @override
  String get currentGeneration => 'Aktualna generacja';

  @override
  String get yourPrediction => 'Twoja odpowiedź';

  @override
  String get submit => 'Zatwierdź';

  @override
  String get correctAnswer => 'Poprawna odpowiedź! Następny poziom...';

  @override
  String get wrongAnswerTryAgain => 'Niepoprawna odpowiedź. Spróbuj ponownie.';

  @override
  String get level => 'Poziom';

  @override
  String get error => 'Błąd';

  @override
  String get saved => 'Zapisano';

  @override
  String get save => 'Zapisz';

  @override
  String get nameOfTheGame => 'Nazwa rozgrywki';

  @override
  String get nameOfTheGameEg => 'np. Moja gra';

  @override
  String get delete => 'Usuń';

  @override
  String get selectSavedGames => 'Wybierz zapisane gry';

  @override
  String get somethingIsWrong => 'Coś poszło nie tak';

  @override
  String get confirmDelete => 'Czy na pewno chcesz usunąć wybrane gry?';
}
