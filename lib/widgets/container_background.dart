import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final Color colorFilterColor;

  const BackgroundContainer({
    super.key,
    required this.child,
    this.colorFilterColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/background.gif"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            colorFilterColor,
            BlendMode.darken,
          ),
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
