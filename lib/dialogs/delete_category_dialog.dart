import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_list_provider.dart';


class DeleteCategoryDialog extends StatefulWidget {
  const DeleteCategoryDialog({required this.categoryIndex, required this.categoryTitle, super.key});

  final int categoryIndex;
  final String categoryTitle;

  @override
  State<DeleteCategoryDialog> createState() => _DeleteCategoryDialogState();
}

class _DeleteCategoryDialogState extends State<DeleteCategoryDialog> {
  bool itemInStock = false;
  String categoryTitle = '';
  late int categoryIndex;


  @override
  void initState() {
    super.initState();
    categoryTitle = widget.categoryTitle;
    categoryIndex = widget.categoryIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [AlertDialog(
            title: Text('Are you sure you want to delete category $categoryTitle?'),
            content: null,
            actions: [
              TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    context.read<CategoryListProvider>().removeCategoryAt(categoryIndex);
                      Navigator.pop(context);
                  },
                  child: const Text('Yes'))
            ]),]
    );
  }
}
