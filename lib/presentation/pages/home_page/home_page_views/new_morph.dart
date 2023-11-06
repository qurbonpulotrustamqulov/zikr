import 'package:flutter/material.dart';

import 'circle_inner_highlight.dart';
import 'circle_inner_shadow.dart';


class NewMorph extends StatelessWidget {
  final bool innerShadow;
  final bool outerShadow;
  final Color highlightColor;
  final Color shadowColor;
  final Color backgroundColor;
  final Widget child;
  const NewMorph({super.key,
    required this.innerShadow,
    required this.outerShadow,
    required this.highlightColor,
    required this.shadowColor,
    required this.backgroundColor,
    required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: (outerShadow)
                  ? [
                BoxShadow(
                    color: highlightColor,
                    offset: const Offset(-1, -1),
                    blurRadius: 2,
                    spreadRadius: 1),
                BoxShadow(
                    color: shadowColor,
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    spreadRadius: 1)
              ]
                  : null)),
      (innerShadow)
          ? ClipPath(
          clipper: HighlightClipper(),
          child: CircleInnerHighlight(
            highlightColor: highlightColor,
            backgroundColor: backgroundColor, key: GlobalKey(),
          ))
          : const SizedBox.shrink(),
      (innerShadow)
          ? ClipPath(
        clipper: ShadowClipper(),
        child: CircleInnerShadow(
          shadowColor: shadowColor,
          backgroundColor: backgroundColor, key: GlobalKey(),
        ),
      )
          : const SizedBox.shrink(),

      child
    ]);
  }

}



class HighlightClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }
}

