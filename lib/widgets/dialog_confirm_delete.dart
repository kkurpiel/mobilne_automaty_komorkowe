import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String message;

  const ConfirmDeleteDialog({
    super.key,
    required this.message,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: message,
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
