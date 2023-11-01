import 'package:flutter/material.dart';

import '../constants.dart';

class SpButton extends StatelessWidget {
  const SpButton({super.key, required this.label, required this.onTap});
  //TODO Clean up class so its specific function is sent through an onTap Function parameter instead of named constructors

  final Function onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        margin: const EdgeInsets.only(top: 6, left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
            color: kColor5,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(3, 3),
                  blurStyle: BlurStyle.normal,
                  blurRadius: 5)
            ]),
        child: MaterialButton(
            onPressed: () {
              onTap();
            },
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ))
    );
  }


}