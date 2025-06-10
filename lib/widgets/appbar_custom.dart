import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final double? elevation;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: centerTitle,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.grey.shade300,
      ),
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: CustomText(
          text: title,
          fontSize: 24,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
