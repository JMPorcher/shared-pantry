import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

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
      color: kColor1,
      child: ListTile(
        leading: Text(itemTitle),
        trailing: CupertinoSwitch(
          activeColor: kColor6,
          trackColor: kColor61,
          value: isAvailable,
          onChanged: toggleSwitch,),
      ),
    );
  }
}
