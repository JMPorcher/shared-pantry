import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/switch.dart';

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
        leading: SizedBox(width: 280, child: Text(itemTitle)),
        trailing: SpSwitch(isAvailable: isAvailable, toggleSwitch: toggleSwitch),
      ),
    );
  }
}


