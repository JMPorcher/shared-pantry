import 'package:flutter/material.dart';
import 'package:shared_pantry/dialogs/add_category_dialog.dart';
import 'package:shared_pantry/widgets/expandable_category_list.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  void showAddDialog() => showDialog(
      context: context,
      builder: (BuildContext context) => const AddCategoryDialog()
  );

  // ExpansionTile builder function

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(child: ExpandableCategoryList()),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.grey,
              child: MaterialButton(
                onPressed: () => showAddDialog(),
                child: const Icon(Icons.add, size: 40.0,)
              ),
            )
          ],
        ),
      ),
    );
  }
}
