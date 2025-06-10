import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilne_automaty_komorkowe/l10n/app_localizations.dart';
import 'package:mobilne_automaty_komorkowe/models/game_model.dart';
import 'package:mobilne_automaty_komorkowe/services/game_save_service.dart';
import 'package:mobilne_automaty_komorkowe/widgets/text_custom.dart';

class SaveGameDialog extends StatefulWidget {
  final GameModel gameModel;

  const SaveGameDialog({
    super.key,
    required this.gameModel,
  });

  @override
  State<SaveGameDialog> createState() => SaveGameDialogState();
}

class SaveGameDialogState extends State<SaveGameDialog> {
  final TextEditingController controller = TextEditingController();
  final GameSaveService gameSaveService = GameSaveService();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: AppLocalizations.of(context)!.nameOfTheGame,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier New',
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 8.0,
                    color: Colors.black54
                  )
                ]
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green.shade700,
                hintText: AppLocalizations.of(context)!.nameOfTheGameEg,
                hintStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier New',
                  color: Colors.white60,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 8.0,
                      color: Colors.black54
                    )
                  ]
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    final inputName = controller.text.trim();
                    final name = inputName.isEmpty
                        ? 'Rozgrywka ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'
                        : inputName;

                    widget.gameModel.name = name;
                    widget.gameModel.date = DateTime.now();
                    Navigator.of(context).pop(name);
                  },
                  label: Text(
                    AppLocalizations.of(context)!.save,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier New',
                      color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 8.0,
                        color: Colors.black54
                      )
                    ]),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    
                    ),
                  
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
