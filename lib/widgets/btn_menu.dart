import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final String route;

  const MenuButton({
    super.key,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.green.shade600, Colors.green.shade900]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 12,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () { 
            Navigator.pushNamed(context, route); 
          },
          style: ElevatedButton.styleFrom(
            elevation: 10,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Courier New',
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 8.0,
                  color: Colors.black54,
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Colors.black54,
                width: 3,
              ),
            ),
          ),
          child: CustomText(text: text),
        ),
      ),
    );
  }
}
