import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';
import 'package:provider/provider.dart';

class EditPantryDialog extends StatefulWidget {
  const EditPantryDialog({required this.pantry, super.key});

  final Pantry pantry;

  @override
  State<EditPantryDialog> createState() => _EditPantryDialogState();
}

class _EditPantryDialogState extends State<EditPantryDialog> {
  bool itemInStock = false;
  String newTitle = '';

  @override
  Widget build(BuildContext context) {
    final Pantry pantry = widget.pantry;
    final title = Provider.of<

    return AlertDialog(
      title: const Text('Edit Pantry name:'),
      content: ChangeNotifierProvider<ValueNotifier<String>>(
        create: (_) => ValueNotifier(pantry.pantryTitle),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: pantry.pantryTitle,
                        autofocus: true,
                        onChanged: (newString) {
                          setState(() {
                            newTitle = newString;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () {
                            if (newTitle.isNotEmpty) {
                              context
                                  .read<PantryProvider>()
                                  .renamePantry(pantry, newTitle);
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
                    child: const Row(
                        children: [
                        Expanded(flex: 3, child: Text('Delete Pantry')),
                    Expanded(flex: 1, child: Icon(Icons.delete)),
            ]
        ),
                  ),
    ),
    ],
    ),
      ),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.pop(context);
    },
    child: const Text('Cancel'))
    ,
    ]
    );
  }
}
