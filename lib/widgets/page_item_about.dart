import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/models/about_model.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPageItem extends StatelessWidget {
  final AboutItem item;

  const AboutPageItem({
      super.key,
      required this.item
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 25),
          CustomText(text: item.title),
          const SizedBox(height: 25),
          Expanded(
            child: SingleChildScrollView(
              child: CustomText(
                text: item.content,
                fontSize: 18,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Center(
            child: TextButton.icon(
              onPressed: () async {
                await launchUrl(Uri.parse(item.url));
              },
              icon: Icon(Icons.open_in_new, color: Colors.green.shade600),
              label: CustomText(
                text: item.learnMore,
                fontSize: 18,
                color: Colors.green.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
