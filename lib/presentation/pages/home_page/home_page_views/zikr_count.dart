import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/controllers/zikr_controller.dart';

import '../../../../services/constants/colors.dart';

class ZikrCount extends StatelessWidget {
  final ZikrController controller;
  final TextEditingController controller2;
  const ZikrCount({super.key, required this.controller, required this.controller2});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return IconButton(
        onPressed: () {
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
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  controller2.text =
                                  "100";
                                },
                                child: const Text("100")),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller2.text =
                                  "300";
                                },
                                child: const Text("300")),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller2.text =
                                  "500";
                                },
                                child: const Text("500"))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 132,
                              height: 40,
                              child: TextField(
                                controller:
                                controller2,
                                textInputAction:
                                TextInputAction
                                    .done,
                                keyboardType:
                                TextInputType
                                    .number,
                                decoration:
                                const InputDecoration(
                                    contentPadding:
                                    EdgeInsets
                                        .only(
                                      left: 15,
                                    ),
                                    hintText:
                                    "Sonini kiriting",
                                    hintStyle: TextStyle(
                                        fontFamily:
                                        "Ubuntu",
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        15,
                                        height:
                                        0)),
                              ),
                            ),
                            const SizedBox(
                                height: 25,
                                width: 25,
                                child: Image(
                                    image: AssetImage(
                                      "assets/images/Edit.png",
                                    )))
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  if (controller2.text
                                      .isNotEmpty &&
                                      int.parse(controller2
                                          .text) >
                                          0) {
                                    controller.changeType(
                                        typeCount: int.parse(
                                            controller2
                                                .text));
                                    if (int.parse(
                                        controller2
                                            .text) >
                                        0) {
                                      controller2
                                          .text = '';
                                      Navigator.pop(
                                          context);
                                    }
                                  }
                                },
                                child: const Text(
                                  "Saqlash",
                                  style: TextStyle(
                                      fontSize: 15,
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
                                child: const Text(
                                  "Bekor qilish",
                                  style: TextStyle(
                                      fontSize: 15,
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
        icon: Container(
          height: 25.sp,
          width: 25.sp,
          padding:
          const EdgeInsets.symmetric(horizontal: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(
                  Radius.circular(45))),
          child: Text(
            type.toString(),
            overflow: TextOverflow.ellipsis,
            style:  const TextStyle(fontSize: 15),
          ),
        ));
  }
}
