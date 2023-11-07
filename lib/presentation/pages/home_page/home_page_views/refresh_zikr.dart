import 'package:flutter/material.dart';
import 'package:untitled/core/controllers/zikr_controller.dart';

class RefreshZikr extends StatefulWidget {
  final ZikrController controller;
  const RefreshZikr({super.key, required this.controller});

  @override
  State<RefreshZikr> createState() => _RefreshZikrState();
}

class _RefreshZikrState extends State<RefreshZikr> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (widget.controller.cart.items.isNotEmpty) {
            for (int i = 0;
            i < widget.controller.cart.items.length;
            i++) {
              widget.controller.cart.items[i].quantity = 0;
            }
            widget.controller.cart.total = 0;
          }

          setState(() {});
        },
        icon: const Image(
          image:
          AssetImage("assets/images/refresh.png"),
          width: 24,
        ))
    ;
  }
}
