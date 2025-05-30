import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/models/about_page_model.dart';
import 'package:mobilne_automaty_komorkowe/widgets/about_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AboutPage extends StatefulWidget 
{
  const AboutPage({super.key});
  
  @override
  State<AboutPage> createState() => AboutPageState();
}
  
class AboutPageState extends State<AboutPage> {
  final PageController controller = PageController();
  late final List<AboutPageModel> pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loc = AppLocalizations.of(context)!;

    pages = [
      AboutPageModel(
        title: loc.whatIsCellularAutomatonTopic,
        content: loc.whatIsCellularAutomatonContent,
        learnMore: loc.whatIsCellularAutomatonLearnMore,
        url: loc.whatIsCellularAutomatonUrl,
      ),
      AboutPageModel(
        title: loc.usageAndMeaningTopic,
        content: loc.usageAndMeaningContent,
        learnMore: loc.usageAndMeaningLearnMore,
        url: loc.usageAndMeaningUrl,
      ),
      AboutPageModel(
        title: loc.conwaysGameOfLifeTopic,
        content: loc.conwaysGameOfLifeContent,
        learnMore: loc.conwaysGameOfLifeLearnMore,
        url: loc.conwaysGameOfLifeUrl,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.aboutCellularAutomatons),
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    body: Container(
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
      child:Column(
        children: [
          const SizedBox(height: 100),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: pages.length,
              itemBuilder: (context, index) => aboutPage(context, pages[index])
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Colors.green.shade800,
              ),
            ),
          ),
        ],
      ),
    ), 
  );
}
