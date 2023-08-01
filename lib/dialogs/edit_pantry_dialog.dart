import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class EditPantryDialog extends StatelessWidget {
  const EditPantryDialog({required this.pantry, super.key});
  final Pantry pantry;
  final bool itemInStock = false;


  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> textNotifier = ValueNotifier<String>(pantry.pantryTitle);
    final pantryTitleTextController = TextEditingController();
    pantryTitleTextController.text = pantry.pantryTitle;
    textNotifier.addListener(() => pantryTitleTextController.text = textNotifier.value);

    return AlertDialog(
        title: const Text('Edit Pantry name:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: pantryTitleTextController,
                      autofocus: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                        onPressed: () {
                          if (pantryTitleTextController.text.isNotEmpty) {
                            context
                                .read<PantryProvider>()
                                .renamePantry(pantry, pantryTitleTextController.text);
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(Icons.save)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                context.read<PantryProvider>().removePantry(pantry);
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0x5BAAD9FF),
                child: const Row(children: [
                  Expanded(flex: 3, child: Text('Delete Pantry')),
                  Expanded(flex: 1, child: Icon(Icons.delete)),
                ]),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
        ]);
  }
}
