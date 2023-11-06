import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../services/constants/colors.dart';

class MyPainter extends CustomPainter {
  int type;
  int count;

  MyPainter({required this.type, required this.count});

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    Paint paint = Paint()
      ..color = CustomColors.c0069c9.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = x / 10;

    Paint paint2 = Paint()
      ..color = CustomColors.c0069c9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = x / 6.4;
    Path path = Path()
      ..moveTo(0, 0)
      ..arcTo(
          Rect.fromCircle(center: Offset(x / 2, x / 2), radius: 2 * x / 4.44),
          2 * pi / 3,
          -count * 2 * pi / type,
          true);

    Path path2 = Path()
      ..moveTo(0, 0)
      ..arcTo(
          Rect.fromCircle(center: Offset(x / 2, x / 2), radius: 2 * x / 4.44),
          2 * pi / 3 - count * 2 * pi / type,
          -pi / 600,
          true);
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
