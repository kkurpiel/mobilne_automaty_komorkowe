import 'package:flutter/material.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/models/grid_model.dart';
import 'package:mobilne_automaty_komorkowe/models/simulation_model.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class SimulationParamsContent extends StatefulWidget {
  const SimulationParamsContent({super.key});

  @override
  SimulationParamsContentState createState() => SimulationParamsContentState();
}

class SimulationParamsContentState extends State<SimulationParamsContent> {
  late SimulationModel simulationModel;

  @override
  void initState() {
    super.initState();
    simulationModel = SimulationModel(
      grid: GridModel(columns: 20, rows: 20),
      fps: 3, 
      hasAliveCells: false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.green.shade700, Colors.green.shade900]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black54, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 12,
              spreadRadius: 3,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: '${AppLocalizations.of(context)!.columns}: ${simulationModel.grid.columns}',
            ),
            Slider(
              min: 10,
              max: 60,
              divisions: 10,
              value: simulationModel.grid.columns.toDouble(),
              activeColor: Colors.green.shade300,
              inactiveColor: Colors.green.shade800,
              thumbColor: Colors.green.shade900,
              onChanged: (value) => setState(() => simulationModel.grid.columns = value.toInt()),
            ),
            CustomText(
              text: '${AppLocalizations.of(context)!.rows}: ${simulationModel.grid.rows}',
            ),
            Slider(
              min: 10,
              max: 80,
              divisions: 14,
              value: simulationModel.grid.rows.toDouble(),
              activeColor: Colors.green.shade300,
              inactiveColor: Colors.green.shade800,
              thumbColor: Colors.green.shade900,
              onChanged: (value) => setState(() => simulationModel.grid.rows = value.toInt()),
            ),
            CustomText(
              text: '${AppLocalizations.of(context)!.fps}: ${simulationModel.fps}',
            ),
            Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: simulationModel.fps.toDouble(),
              activeColor: Colors.green.shade300,
              inactiveColor: Colors.green.shade800,
              thumbColor: Colors.green.shade900,
              onChanged: (value) => setState(() => simulationModel.fps = value.toInt()),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(simulationModel);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier New',
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 8.0,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
