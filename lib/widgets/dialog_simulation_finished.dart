import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class NoMoreAliveCellsDialog extends StatelessWidget {
  final String message;
  final VoidCallback restartSimulation;

  const NoMoreAliveCellsDialog({
    super.key, 
    required this.message,
    required this.restartSimulation
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green.shade600, Colors.green.shade900]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black54, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 12,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                text: message,
                fontSize: 18,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              iconSize: 50,
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
                restartSimulation();
              },
            ),
          ],
        ),
      ),
    );
  }
}
