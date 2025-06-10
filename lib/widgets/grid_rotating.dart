import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';
import 'package:mobilne_automaty_komorkowe/widgets/grid_selectable.dart';

class RotatingGrid extends StatefulWidget {
  final GridModel frontGrid;
  final GridModel backGrid;
  final double cellSize;

  const RotatingGrid({
    super.key,
    required this.frontGrid,
    required this.backGrid,
    required this.cellSize,
  });

  @override
  State<RotatingGrid> createState() => RotatingGridState();
}

class RotatingGridState extends State<RotatingGrid> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isFrontVisible = true;
  bool get getIsFrontVisible => isFrontVisible;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final isUnder = animation.value > 0.5;
            final displayGrid = isUnder ? widget.backGrid : widget.frontGrid;

            final rotationY = animation.value * pi;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(rotationY),
              child: isUnder
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: SelectableGrid(
                      gridModel: displayGrid,
                      cellSize: widget.cellSize,
                    ),
                  )
                : SelectableGrid(
                    gridModel: displayGrid,
                    cellSize: widget.cellSize,
                    isEditable: false,
                  ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void flipCard() {
    if (isFrontVisible) {
      controller.forward();
    } else {
      controller.reverse();
    }
    setState(() {
      isFrontVisible = !isFrontVisible;
    });
  }
}
