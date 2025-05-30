import 'package:flutter/material.dart';

Widget menuButton(BuildContext context, String text, VoidCallback onPressed) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
          elevation: 10,
          shadowColor: Colors.black54,
          backgroundColor: Colors.green.shade800,
          foregroundColor: Colors.grey.shade300,
           textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Courier New',
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 8.0,
                color: Colors.black54
              )
            ]
          ),
          padding: const EdgeInsets.symmetric(vertical: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
    child: Text(text),
  ),
);
