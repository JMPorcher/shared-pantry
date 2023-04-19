import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/expandable_category_list.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {


  // ExpansionTile builder function

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: ExpandableCategoryList()),
          ],
        ),
      ),
    );
  }
}
