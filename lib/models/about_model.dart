import 'dart:core';

/// Model pojedynczej strony wykorzystywany w widoku '/about'
class AboutItem {
  final String title;
  final String content;
  final String learnMore;
  final String url; 

  AboutItem({
    required this.title,
    required this.content,
    required this.learnMore,
    required this.url
  });
}
