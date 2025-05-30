import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/models/about_page_model.dart';
import 'package:url_launcher/url_launcher.dart';

Widget aboutPage(BuildContext context, AboutPageModel model) => Padding(
  padding: const EdgeInsets.all(24.0),
  child: Column(
    children: [
      const SizedBox(height: 25),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(offset: Offset(1, 1), blurRadius: 1.0),
          ],
        ),
      ),
      const SizedBox(height: 25),
      Expanded(
        child: SingleChildScrollView(
          child: Text(
            model.content,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              shadows: [Shadow(offset: Offset(1, 1), blurRadius: 1.0)],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
      Center(
        child: TextButton.icon(
          onPressed: () async {
              await launchUrl(Uri.parse(model.url));
          },
          icon: const Icon(Icons.open_in_new, color: Colors.lightGreen),
          label: Text(
            model.learnMore,
            style: const TextStyle(
              color: Colors.lightGreen,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ],
  ),
);
