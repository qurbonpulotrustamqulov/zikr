import 'package:flutter/material.dart';

import '../../../../services/constants/images.dart';

class ChangeImage extends StatelessWidget {
  const ChangeImage({super.key});

  @override
  Widget build(BuildContext context) {
    double x= MediaQuery.sizeOf(context).width;
    double y= MediaQuery.sizeOf(context).height;
    return  SizedBox(
      width: x,
      child: DateTime.now().hour >= 3 && DateTime.now().hour <= 9
          ? Image(
          image: CustomImages.bomdod,
          height: 0.31 * y,
          fit: BoxFit.fill)
          : DateTime.now().hour > 9 && DateTime.now().hour <= 15
          ? Image(
          image: CustomImages.peshin,
          height: 0.31 * y,
          fit: BoxFit.fill)
          : DateTime.now().hour > 15 && DateTime.now().hour < 17
          ? Image(
          image: CustomImages.asr,
          height: 0.31 * y,
          fit: BoxFit.fill)
          : DateTime.now().hour >= 17 && DateTime.now().hour <= 19
          ? Image(
          image: CustomImages.shom,
          height: 0.31 * y,
          fit: BoxFit.fill)
          : Image(
          image: CustomImages.xufton,
          height: 0.31 * y,
          fit: BoxFit.fill),
    );
  }
}
