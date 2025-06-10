import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/models/about_model.dart';
import 'package:mobilne_automaty_komorkowe/utils/snackbar_custom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/appbar_custom.dart';
import 'package:mobilne_automaty_komorkowe/widgets/container_background.dart';
import 'package:mobilne_automaty_komorkowe/widgets/page_item_about.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});
  
  @override
  State<AboutPage> createState() => AboutPageState();
}
  
class AboutPageState extends State<AboutPage> {
  /// Kontroler strony
  late final PageController controller = PageController();

  /// Aktualny index strony
  double currentPageIndex = 0.0;

  /// Lista z itemami (stronami do wyswietlenia)
  List<AboutItem> items = [];

  /// Inicjlizacja stanu widgetu
  @override
  void initState() {
    super.initState();
    setPageControllerListener();
  }

  /// Inicjowanie listy ze stronami zawierajacymi informacje
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    items = [
      AboutItem(
        title: AppLocalizations.of(context)!.whatIsCellularAutomatonTopic,
        content: AppLocalizations.of(context)!.whatIsCellularAutomatonContent,
        learnMore: AppLocalizations.of(context)!.whatIsCellularAutomatonLearnMore,
        url: AppLocalizations.of(context)!.whatIsCellularAutomatonUrl,
      ),
      AboutItem(
        title: AppLocalizations.of(context)!.usageAndMeaningTopic,
        content: AppLocalizations.of(context)!.usageAndMeaningContent,
        learnMore: AppLocalizations.of(context)!.usageAndMeaningLearnMore,
        url: AppLocalizations.of(context)!.usageAndMeaningUrl,
      ),
      AboutItem(
        title: AppLocalizations.of(context)!.conwaysGameOfLifeTopic,
        content: AppLocalizations.of(context)!.conwaysGameOfLifeContent,
        learnMore: AppLocalizations.of(context)!.conwaysGameOfLifeLearnMore,
        url: AppLocalizations.of(context)!.conwaysGameOfLifeUrl,
      ),
    ];
  }

  /// Metoda budujaca widget z animacja przejscia pomiedzy stronami
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.aboutCellularAutomatons),
      body: BackgroundContainer(
        colorFilterColor: Colors.black45,
        child: Column(
          children: [
            Expanded( 
              child: PageView.builder(
                controller: controller,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final rotationValue = currentPageIndex - index;
                  if (rotationValue.abs() <= 1) {
                    return Transform(
                      transform: Matrix4.identity()..rotateX(rotationValue),
                      child: AboutPageItem(item: items[index]),
                    );
                  } else {
                    return AboutPageItem(item: items[index]);
                  }
                }
              ),
            ),
            const SizedBox(height: 25),
            SmoothPageIndicator(
              controller: controller,
              count: items.length,
              effect: SwapEffect(
                activeDotColor: Colors.green.shade800,
                dotColor: Colors.white54,
                spacing: 12
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  /// Zwolnienie kontrolera stron
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Sprawdzanie przewijania stron i akutualizacja aktualnego indeksu
  void setPageControllerListener() {
    try {
      controller.addListener(() {
        final page = controller.page ?? 0.0;
        if ((currentPageIndex - page).abs() > 0.01) {
          setState(() {
            currentPageIndex = page;
          });
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
}
