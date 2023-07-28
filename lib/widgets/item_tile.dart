import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {

  const ItemTile({
    required this.itemTitle,
    required this.isAvailable,
    super.key,
    required this.toggleSwitch});

  final String itemTitle;
  final bool isAvailable;
  final Function(bool) toggleSwitch;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x99FFFFFF),
      child: ListTile(
        leading: Text(itemTitle),
        trailing: CupertinoSwitch(
          value: isAvailable,
          onChanged: toggleSwitch,),
      ),
    );
  }
}
