import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class ItemTitleInputLine extends StatelessWidget {
  const ItemTitleInputLine({
    super.key,
    required this.textEditingController,
    required this.fieldIsEmpty,
  });

  final TextEditingController textEditingController;
  final ValueNotifier<bool> fieldIsEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 40,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextField(
        onChanged: (_) {
          if (textEditingController.text.isNotEmpty) {
            fieldIsEmpty.value = false;
          } else {
            fieldIsEmpty.value = true;
          }
        },
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.start,
        inputFormatters: [LengthLimitingTextInputFormatter(kItemLengthLimit)],
        controller: textEditingController,
        decoration: const InputDecoration(
          hintText: '(Add item)',
          hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 3)
          ),
        ),
      ),
    );
  }
}