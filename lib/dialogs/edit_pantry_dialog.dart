import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class EditPantryDialog extends StatelessWidget {
  EditPantryDialog({required this.pantry, super.key});
  final Pantry pantry;
  final bool itemInStock = false;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> textNotifier = ValueNotifier<String>(pantry.pantryTitle);
    _controller.text = pantry.pantryTitle;
    textNotifier.addListener(() => _controller.text = textNotifier.value);

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
                      controller: _controller,
                      autofocus: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            context
                                .read<PantryProvider>()
                                .renamePantry(pantry, _controller.text);
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
                child: Row(children: const [
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
