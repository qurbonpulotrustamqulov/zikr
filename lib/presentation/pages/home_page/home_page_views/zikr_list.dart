import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/controllers/zikr_controller.dart';
import '../../../../services/constants/colors.dart';
import '../../../../services/constants/images.dart';

class ZikrList extends StatelessWidget {
  final ZikrController controller;
  final TextEditingController controller1;
  const ZikrList({super.key, required this.controller, required this.controller1});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if(controller.showAll==true){
            controller.showAllZikr();
          }
          showDialog(
            context: context,
            builder: (context) => ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(18))),
                    icon: Column(
                      children: [
                        SizedBox(
                          width: 294.sp,
                          height: controller.showAll==false && allZikr.length>3 ? 150:allZikr.length< 6 ?allZikr.length*34: 6*34,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int i = 0;
                                controller.showAll == true
                                    ? i < allZikr.length
                                    : controller.showAll ==
                                    false &&
                                    allZikr.length >=
                                        3
                                    ? i < 3
                                    : i <
                                    allZikr
                                        .length;
                                i++)
                                  SizedBox(
                                    height: 35,
                                    child: Row(
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (allZikr.isNotEmpty) {
                                                  controller.removeZikr(
                                                      id: allZikr[
                                                      i]
                                                          .id);
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Zikr o'chirildi")));
                                                }
                                                if (controller.cart.items.isNotEmpty && allZikr.isEmpty) {
                                                  for (int i = 0;
                                                  i < controller.cart.items.length;
                                                  i++) {
                                                    controller.cart.items[i].quantity = 0;
                                                  }
                                                  controller.cart.total = 0;
                                                }
                                              },
                                              child:  Image(
                                                image: const AssetImage(
                                                    "assets/images/Frame.png"),
                                                width: 17.sp, height: 17.sp,
                                              ),
                                            );
                                          }
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(width: 150,
                                          child: Text(
                                            allZikr[i].name,overflow: TextOverflow.ellipsis,
                                            style:  TextStyle(
                                                fontFamily:
                                                "Ubuntu",
                                                color:
                                                CustomColors
                                                    .c0069c9,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize: 15.sp),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {controller.selected(
                                              selection:
                                              allZikr[
                                              i]);
                                          },
                                          child: Icon(
                                            allZikr[i].succes ==
                                                false
                                                ? Icons
                                                .check_box_outline_blank
                                                : Icons
                                                .check_box_outlined,
                                            color:
                                            CustomColors
                                                .c0069c9,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 132.sp,
                              height: 40,
                              child: TextField(
                                textAlign: TextAlign.center,
                                maxLines: null,
                                controller:
                                controller1,
                                decoration:
                                 InputDecoration(

                                    contentPadding:
                                    const EdgeInsets
                                        .only(
                                      left: 15,
                                    ),
                                    hintText:
                                    "Zikr qo'shing",
                                    hintStyle: TextStyle(
                                        fontFamily:
                                        "Ubuntu",
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        15.sp,
                                        height:
                                        0)),
                              ),
                            ),
                             SizedBox(
                                height: 20.sp,
                                width: 22.sp,
                                child: const Image(
                                    image: AssetImage(
                                      "assets/images/Edit.png",
                                    ), fit: BoxFit.cover,))
                          ],
                        ),
                         SizedBox(
                          height: 22.sp,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.showAllZikr();
                                },
                                icon:  Image(height: 20.sp,
                                  width: 20.sp,
                                  image: const AssetImage(
                                      "assets/images/Arrow - Down Circle.png"),
                                )),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  if(controller.showAll == false){
                                    controller.showAllZikr();
                                  }
                                  if (controller1.text
                                      .isNotEmpty) {
                                    controller.addToZikr(
                                        zikr: controller1
                                            .text
                                            .trim());
                                    controller1.text =
                                    '';
                                  }
                                },
                                child:  Text(
                                  "Saqlash",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight:
                                      FontWeight
                                          .w400,
                                      fontFamily:
                                      "Ubuntu",
                                      color:
                                      CustomColors
                                          .c0069c9),
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                      context);
                                },
                                child:  Text(
                                  "Bekor qilish",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight:
                                      FontWeight
                                          .w400,
                                      fontFamily:
                                      "Ubuntu",
                                      color:
                                      CustomColors
                                          .c0069c9),
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          );
        },
        icon:
         Image(image: CustomImages.select, height: 19.5.sp,width: 19.5.sp, ));
  }
}
