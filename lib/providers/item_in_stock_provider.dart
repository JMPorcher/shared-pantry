import 'package:flutter/material.dart';

class ItemInStockProvider extends ValueNotifier<bool> {
  ItemInStockProvider(super.value);

  void switchInStockState() => value = !value;
}