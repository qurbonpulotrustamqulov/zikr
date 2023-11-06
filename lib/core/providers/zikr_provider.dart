import 'package:flutter/material.dart';

import '../controllers/zikr_controller.dart';

class Provider extends InheritedWidget {
  final ZikrController controller;

  const Provider({required this.controller, super.key, required super.child});

  static ZikrController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.controller;
  }

  @override
  bool updateShouldNotify(covariant Provider oldWidget) {
    return oldWidget.controller.cart != controller.cart ||
        oldWidget.controller.isChanged != controller.isChanged ||
        oldWidget.controller.hasSound != controller.hasSound ||
        oldWidget.controller.adZikr != controller.adZikr||
    oldWidget.controller.isRemove != controller.isRemove||
    oldWidget.controller.changeTypeCount != controller.changeTypeCount||
    oldWidget.controller.showAll != controller.showAll;
  }
}
