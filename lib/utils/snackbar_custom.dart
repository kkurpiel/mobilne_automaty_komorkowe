import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

SnackBar buildCustomSnackBar(String message, {bool isError = false}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isError
              ? [Colors.red.shade200, Colors.red.shade400]
              : [Colors.green.shade600, Colors.green.shade900],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black45, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 12,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: CustomText(
        text: message,
        fontSize: 18,
      ),
    ),
  );
}
