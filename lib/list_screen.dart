import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/add_dialog.dart';
import 'package:shared_pantry/widgets/item_list.dart';
import 'package:provider/provider.dart';

import 'models/item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool switchState = false;

  Future<Item?> showAddDialog() => showDialog<Item>(
      context: context,
      builder: (BuildContext context) => AddDialog());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ItemList(),
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
