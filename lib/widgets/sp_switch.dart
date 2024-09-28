import 'package:flutter/material.dart';

import '../constants.dart';

class SpSwitch extends StatelessWidget {
  const SpSwitch({
    super.key,
    required this.switchValue,
    required this.toggleSwitch,
  });

  final bool switchValue;
  final Function(bool p1) toggleSwitch;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: kColor6,
      inactiveThumbColor: kColor1,
      value: switchValue,
      onChanged: toggleSwitch,
      activeTrackColor: kColor61,
      inactiveTrackColor: Colors.grey.withOpacity(0.5),
      thumbColor: WidgetStateColor.resolveWith(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return kColor6;
            }
            return kColor1;
          }),
    );
  }
}