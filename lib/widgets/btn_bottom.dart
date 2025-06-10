import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final VoidCallback? onPressed;
  final bool isVisible;

  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 48,
    this.isVisible = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize + 24,
      height: iconSize + 24,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: isVisible ? [Colors.green.shade600, Colors.green.shade900] : [Colors.transparent, Colors.transparent]),
        shape: BoxShape.circle,
          border: Border.all(
          color: isVisible ? Colors.black54 : Colors.transparent,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: isVisible ? Colors.black87 : Colors.transparent,
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: isVisible ? Colors.white : Colors.transparent),
        iconSize: iconSize,
        onPressed: onPressed,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
