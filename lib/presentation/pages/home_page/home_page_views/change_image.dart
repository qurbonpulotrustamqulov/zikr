import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../services/constants/images.dart';

class ChangeImage extends StatelessWidget {
  const ChangeImage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SizedBox(
      width: 380.sp,
      child: DateTime.now().hour >= 3 && DateTime.now().hour <= 9
          ? Image(image: CustomImages.bomdod, height: 228.sp, fit: BoxFit.fill)
          : DateTime.now().hour > 9 && DateTime.now().hour <= 15
              ? Image(
                  image: CustomImages.peshin, height: 228.sp, fit: BoxFit.fill)
              : DateTime.now().hour > 15 && DateTime.now().hour < 17
                  ? Image(
                      image: CustomImages.asr, height: 228.sp, fit: BoxFit.fill)
                  : DateTime.now().hour >= 17 && DateTime.now().hour <= 19
                      ? Image(
                          image: CustomImages.shom,
                          height: 228.sp,
                          fit: BoxFit.fill)
                      : Image(
                          image: CustomImages.xufton,
                          height: 228.sp,
                          fit: BoxFit.fill),
    );
  }
}
