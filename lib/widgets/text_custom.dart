import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final Color color; 
  final int? maxLines;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 22,
    this.textAlign = TextAlign.start,
    this.color = Colors.white,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'Courier New',
        color: color,
        shadows: const [
          Shadow(
            offset: Offset(2, 2),
            blurRadius: 8.0,
            color: Colors.black54
          )
        ]
      ),
      textAlign: textAlign,
    );
  }
}
