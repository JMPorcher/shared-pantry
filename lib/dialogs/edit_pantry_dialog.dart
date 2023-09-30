import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class EditPantryDialog extends StatelessWidget {
  const EditPantryDialog({required this.pantry, super.key});
  final Pantry pantry;
  final bool itemInStock = false;


  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> textNotifier = ValueNotifier<String>(pantry.title);
    final pantryTitleTextController = TextEditingController();
    pantryTitleTextController.text = pantry.title;
    textNotifier.addListener(() => pantryTitleTextController.text = textNotifier.value);

    return AlertDialog(
        title: const Text('Edit Pantry name:', style: TextStyle(color: kColor51),),
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
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kColor51, width: 1.5))),
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
                        child: const Icon(Icons.save, color: kColor51,)),
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
                color: kColor51,
                child: const Row(children: [
                  Expanded(flex: 3, child: Text('Delete Pantry', style: TextStyle(color: Colors.white),)),
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
              child: const Text('Cancel', style: TextStyle(color: kColor51)), ),
        ]);
  }
}
