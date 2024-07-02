import 'package:flutter/material.dart';

import '../constants.dart';

class SpButton extends StatelessWidget {
  const SpButton.filledButton(
      {super.key,
      required this.child,
      required this.onTap,
      this.verticalPadding = 6,
      this.horizontalPadding = 12,
      this.fillColor})
      : outlineColor = null;

  const SpButton.outlineButton(
      {super.key,
      required this.child,
      required this.onTap,
      this.verticalPadding = 6,
      this.horizontalPadding = 12})
      : fillColor = kColor1,
        outlineColor = kColor5;

  final Function onTap;
  final Widget child;
  final Color? fillColor;
  final Color? outlineColor;
  final double verticalPadding;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        decoration: BoxDecoration(
            color: fillColor ?? kColor5,
            border: Border.all(width: 2, color: outlineColor ?? Colors.white.withOpacity(0)),
            borderRadius: BorderRadius.circular(12),
        ),
        child: MaterialButton(
            onPressed: () {
              onTap();
            },
            child: child));
  }
}

class AddItemButton extends StatelessWidget {
  const AddItemButton(
      {super.key, required this.fieldIsEmpty, required this.onPressed});

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
                          ? WidgetStateProperty.all(kColor11)
                          : WidgetStateProperty.all(kColor111),
                      padding:
                          WidgetStateProperty.all(const EdgeInsets.all(0))),
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
