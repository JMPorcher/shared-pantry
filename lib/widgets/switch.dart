import 'package:flutter/material.dart';

import '../constants.dart';

class SpSwitch extends StatelessWidget {
  const SpSwitch({
    super.key,
    required this.isAvailable,
    required this.toggleSwitch,
  });

  final bool isAvailable;
  final Function(bool p1) toggleSwitch;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: kColor6,
      inactiveThumbColor: kColor1,
      trackColor: MaterialStateProperty.all(kColor61),
      value: isAvailable,
      onChanged: toggleSwitch,);
  }
}