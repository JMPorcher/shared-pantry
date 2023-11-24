import 'package:flutter/material.dart';

import '../constants.dart';

class SpButton extends StatelessWidget {
  const SpButton({
    super.key,
    required this.child,
    required this.onTap,
    this.color = kColor5,
    this.verticalPadding = 6,
    this.horizontalPadding = 12});

  final Function onTap;
  final Widget child;
  final Color color;
  final double verticalPadding;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        margin: const EdgeInsets.only(top: 6, left: 10, right: 10, bottom: 20),
        decoration: BoxDecoration(
            color: color,
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
            child: child)
    );
  }
}


class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
    required this.fieldIsEmpty,
    required this.onPressed
  });

  final ValueNotifier<bool> fieldIsEmpty;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, top: 2, right: 12, bottom: 2),
      child: SizedBox(
          width: 30,
          height: 27,
          child: ValueListenableBuilder<bool>(
              valueListenable: fieldIsEmpty,
              builder:
                  (BuildContext context, bool fieldIsEmpty, Widget? child) {
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: fieldIsEmpty
                          ? MaterialStateProperty.all(kColor11)
                          : MaterialStateProperty.all(kColor111),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.all(0))),
                  onPressed: () => onPressed(),
                  child: const Icon(
                    Icons.add,
                    color: kColor1,
                  ),
                );
              })),
    );
  }
}