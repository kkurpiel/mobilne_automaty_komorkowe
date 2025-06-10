import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';
import 'package:mobilne_automaty_komorkowe/widgets/grid_painter.dart';

class SelectableGrid extends StatefulWidget {
  final GridModel gridModel;
  final double cellSize;
  final bool isEditable;

  const SelectableGrid({
    super.key,
    required this.gridModel,
    required this.cellSize,
    this.isEditable=true
  });

  @override
  State<SelectableGrid> createState() => SelectableGridState();
}

class SelectableGridState extends State<SelectableGrid> {
  int? lastTouchedRow;
  int? lastTouchedCol;
  int pointerCount = 0;
  bool hasMoved = false;

  List<List<bool>> get grid => widget.gridModel.selectedCells;

  @override
  Widget build(BuildContext context) {
    final gridWidth = widget.gridModel.columns * widget.cellSize;
    final gridHeight = widget.gridModel.rows * widget.cellSize;

    return Listener(
      behavior: HitTestBehavior.translucent,
  
      onPointerDown: (event) {
        pointerCount++;
        hasMoved = false;
        if (pointerCount == 1) {
          handleTouch(event.localPosition);
        }
      },

      onPointerMove: (event) {
        hasMoved = true;
        if (pointerCount == 1) {
          handleTouch(event.localPosition);
        }
      },

      onPointerUp: (event) {
        pointerCount = (pointerCount - 1).clamp(0, double.infinity).toInt();
        lastTouchedRow = null;
        lastTouchedCol = null;
      },
      onPointerCancel: (event) {
        pointerCount = (pointerCount - 1).clamp(0, double.infinity).toInt();
        lastTouchedRow = null;
        lastTouchedCol = null;
      },

      child: SizedBox(
        width: gridWidth,
        height: gridHeight,
        child: CustomPaint(
          painter: GridPainter(grid, widget.cellSize),
        ),
      ),
    );
  }

  void toggleCell(int row, int col) {
    if (!widget.isEditable) return;
    
    setState(() {
      grid[row][col] = !grid[row][col];
    });
  }

  void handleTouch(Offset position) {
    if (!widget.isEditable) return;

    final col = (position.dx ~/ widget.cellSize).clamp(0, widget.gridModel.columns - 1);
    final row = (position.dy ~/ widget.cellSize).clamp(0, widget.gridModel.rows - 1);

    if (row != lastTouchedRow || col != lastTouchedCol) {
      toggleCell(row, col);
      lastTouchedRow = row;
      lastTouchedCol = col;
    }
  }
}
