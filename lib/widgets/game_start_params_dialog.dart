import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/models/game_start_params_model.dart';

Future<void> gameStartParamsDialog({
  required BuildContext context,
  required GameStartParamsModel gameStartParamsModel,
  required void Function(int calculatedPixelsPerCell) onStart
}) async {
  final size = MediaQuery.of(context).size;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.green.shade800,
    builder: (context) => StatefulBuilder(
      builder: (context, setSheetState) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            Text('${AppLocalizations.of(context)!.columns}: ${gameStartParamsModel.columns}'),
            Slider(
              thumbColor: Colors.green.shade900,
              activeColor: Colors.green.shade700,
              inactiveColor: Colors.green.shade300,
              min: 10,
              max: 80,
              divisions: 14,
              value: gameStartParamsModel.columns.toDouble(),
              onChanged: (value) => setSheetState(() => gameStartParamsModel.columns = value.toInt()),
            ),
            Text('${AppLocalizations.of(context)!.rows}: ${gameStartParamsModel.rows}'),
            Slider(              
              thumbColor: Colors.green.shade900,
              activeColor: Colors.green.shade700,
              inactiveColor: Colors.green.shade300,
              min: 10,
              max: 80,
              divisions: 14,
              value: gameStartParamsModel.rows.toDouble(),
              onChanged: (value) => setSheetState(() => gameStartParamsModel.rows = value.toInt()),
            ),
            Text('${AppLocalizations.of(context)!.fps}: ${gameStartParamsModel.fps}'),
            Slider(
              thumbColor: Colors.green.shade900,
              activeColor: Colors.green.shade700,
              inactiveColor: Colors.green.shade300,
              min: 1,
              max: 10,
              divisions: 9,
              value: gameStartParamsModel.fps.toDouble(),
              onChanged: (value) => setSheetState(() => gameStartParamsModel.fps = value.toInt()),
            ),
            ElevatedButton(
              onPressed: () {
                final calculatedPixelsPerCell = min(
                  size.width / gameStartParamsModel.columns,
                  size.height / gameStartParamsModel.rows,
                ).floor();

                onStart(calculatedPixelsPerCell);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shadowColor: Colors.black54,
                backgroundColor: Colors.green.shade800,
                foregroundColor: Colors.grey.shade300,
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier New',
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 8.0,
                      color: Colors.black54
                    )
                  ]
                ),
              padding: const EdgeInsets.symmetric(horizontal:40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
              child: const Text('Start'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    )).whenComplete(() {
      final calculatedPixelsPerCell = min(
        size.width / gameStartParamsModel.columns,
        size.height / gameStartParamsModel.rows,
      ).floor();

      onStart(calculatedPixelsPerCell);
  });
}
