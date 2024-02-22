import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/services/database_services.dart';
import '../models/pantry.dart';
import '../providers/pantry_provider.dart';
import 'package:provider/provider.dart';

class EditPantryDialog extends StatelessWidget {
  const EditPantryDialog(this.pantry, {super.key});
  final Pantry pantry;
  final bool itemInStock = false;


  @override
  Widget build(BuildContext context) {
    final Pantry pantry = context.watch<Pantry>();
    final ValueNotifier<String> textNotifier = ValueNotifier<String>(pantry.title);
    final pantryTitleTextController = TextEditingController();
    pantryTitleTextController.text = pantry.title;
    textNotifier.addListener(() => pantryTitleTextController.text = textNotifier.value);


    return AlertDialog(
        title: const Text('Edit Pantry name:', style: TextStyle(color: kColor51),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EditPantryContainer(pantryTitleTextController: pantryTitleTextController, pantry: pantry),
            const SizedBox(height: 50),
            DeletePantryRow(pantry: pantry),
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

class EditPantryContainer extends StatelessWidget {
  const EditPantryContainer({
    super.key,
    required this.pantryTitleTextController,
    required this.pantry,
  });

  final TextEditingController pantryTitleTextController;
  final Pantry pantry;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                onPressed: () async {
                  if (pantryTitleTextController.text.isNotEmpty) {
                    DatabaseService().editPantryTitle(pantry.id, pantry.title);
                    Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.save, color: kColor51,)),
          ),
        ],
      ),
    );
  }
}

class DeletePantryRow extends StatelessWidget {
  const DeletePantryRow({
    super.key,
    required this.pantry,
  });

  final Pantry pantry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatabaseService().removePantryFromDatabase(pantry.id);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: kColor51),
        child: const Row(children: [
          Expanded(flex: 3, child: Text('Delete Pantry', style: TextStyle(color: Colors.white),)),
          Expanded(flex: 1, child: Icon(Icons.delete, color: kColor1,)),
        ]),
      ),
    );
  }
}
