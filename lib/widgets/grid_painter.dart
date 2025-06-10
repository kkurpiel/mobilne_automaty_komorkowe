import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final List<List<bool>> grid;
  final double cellSize;

  GridPainter(this.grid, this.cellSize);

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        final rect = Rect.fromLTWH(
          col * cellSize,
          row * cellSize,
          cellSize,
          cellSize,
        );

        final shader = LinearGradient(
          colors: grid[row][col] ? [Colors.green.shade600, Colors.green.shade900] : [Colors.transparent, Colors.transparent],
        ).createShader(rect);

        final fillPaint = Paint()
        ..shader = shader
        ..style = PaintingStyle.fill;

        canvas.drawRect(rect, fillPaint);
        canvas.drawRect(rect, borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => true;
}
