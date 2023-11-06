import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:untitled/core/controllers/zikr_controller.dart';
import 'package:untitled/core/providers/zikr_provider.dart';
import 'package:untitled/main.dart';
import 'package:untitled/services/constants/colors.dart';
import 'package:untitled/services/constants/images.dart';

import '../../../services/constants/starings.dart';
import 'home_page_views/change_image.dart';
import 'home_page_views/my_painter.dart';
import 'home_page_views/new_morph.dart';
import 'home_page_views/voice_control.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AudioPlayer _audioPlayer;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  void initState() {
    _audioPlayer = AudioPlayer()..setAsset("assets/sound/effect.mp3");
    allZikr = zikrRepository.readTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ZikrController controller = Provider.of(context);
    int counter = 0;

    final double x = MediaQuery.sizeOf(context).width;
    final double y = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ///Yuqori qismdagi rasmlar almashishi
          const ChangeImage(),

          ///Zikrlar sanog'i hamda zikr qoshish joylashtirilgan asosiy qism
          Align(
            alignment: Alignment.bottomCenter,
            child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  return Container(
                    height: 0.73 * y,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.cf5f5f5,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(x * 0.08),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ///bosilganda zikrlar ro'yxatini ochib beruvchi tugma
                              IconButton(
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
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18))),
                                              icon: Column(
                                                children: [
                                                  SizedBox(
                                                    height: controller.showAll==false && allZikr.length>3 ? 120:allZikr.length< 6 ?allZikr.length*34: 6*34,
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
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      if (allZikr.isNotEmpty) {
                                                                        controller.removeZikr(
                                                                            id: allZikr[
                                                                                    i]
                                                                                .id);
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
                                                                    child: Image(
                                                                      image: AssetImage(
                                                                          "assets/images/Frame.png"),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 10),
                                                                  SizedBox(width: 150,
                                                                    child: Text(
                                                                      allZikr[i].name,overflow: TextOverflow.ellipsis,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              "Ubuntu",
                                                                          color:
                                                                              CustomColors
                                                                                  .c0069c9,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize: 15),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
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
                                                  Divider(),
                                                  Row(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: 132,
                                                        height: 40,
                                                        child: TextField(
                                                          controller:
                                                          controller1,
                                                          decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                              EdgeInsets
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
                                                                  15,
                                                                  height:
                                                                  0)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 25,
                                                          width: 25,
                                                          child: Image(
                                                              image: AssetImage(
                                                                "assets/images/Edit.png",
                                                              )))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            controller.showAllZikr();
                                                          },
                                                          icon: Image(
                                                            image: AssetImage(
                                                                "assets/images/Arrow - Down Circle.png"),
                                                          )),
                                                      Spacer(),
                                                      GestureDetector(
                                                          onTap: () {
                                                            print(zikrRepository.readFirst());
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
                                                          child: Text(
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
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
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
                                  icon:
                                      const Image(image: CustomImages.select)),
                              const Spacer(),

                              ///zikrlar sanog'ini o'zgartirish
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ListenableBuilder(
                                          listenable: controller,
                                          builder: (context, _) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
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
                                                          child: Text("100")),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            controller2.text =
                                                                "300";
                                                          },
                                                          child: Text("300")),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            controller2.text =
                                                                "500";
                                                          },
                                                          child: Text("500"))
                                                    ],
                                                  ),
                                                  SizedBox(
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
                                                              InputDecoration(
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
                                                      SizedBox(
                                                          height: 25,
                                                          width: 25,
                                                          child: Image(
                                                              image: AssetImage(
                                                            "assets/images/Edit.png",
                                                          )))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Spacer(),
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
                                                          child: Text(
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
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(45))),
                                    child: Text(
                                      type.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  )),
                              IconButton(
                                  onPressed: controller.sound,
                                  icon: controller.hasSound == 1
                                      ? const Image(
                                          image: AssetImage(
                                            "assets/images/volume-down.png",
                                          ),
                                          width: 25,
                                        )
                                      : controller.hasSound == 2
                                          ? const Image(
                                              image: AssetImage(
                                                  "assets/images/volume-mute.png"),
                                              width: 25,
                                            )
                                          : const Image(
                                              image: AssetImage(
                                                  "assets/images/waveform.png"))),
                              IconButton(
                                  onPressed: () {
                                    if (controller.cart.items.isNotEmpty) {
                                      for (int i = 0;
                                          i < controller.cart.items.length;
                                          i++) {
                                        controller.cart.items[i].quantity = 0;
                                      }
                                      controller.cart.total = 0;
                                    }

                                    setState(() {});
                                  },
                                  icon: const Image(
                                    image:
                                        AssetImage("assets/images/refresh.png"),
                                    width: 24,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: x * 0.45,
                          width: x * 0.45,
                          child: ListenableBuilder(
                              listenable: controller,
                              builder: (context, _) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    NewMorph(
                                        innerShadow: true,
                                        outerShadow: false,
                                        highlightColor: const Color(0xff98cfe1),
                                        shadowColor: const Color(0xff000000)
                                            .withOpacity(0.2),
                                        backgroundColor:
                                            const Color(0xffa2dcef),
                                        child: const SizedBox()),
                                    LayoutBuilder(
                                        builder: (context, constraints) {
                                      return SizedBox(
                                        width: constraints.maxWidth * 0.8,
                                        height: constraints.maxWidth * 0.8,
                                        child: NewMorph(
                                          innerShadow: false,
                                          outerShadow: true,
                                          highlightColor:
                                              Colors.white.withOpacity(0.05),
                                          shadowColor: const Color(0xff000000)
                                              .withOpacity(0.3),
                                          backgroundColor:
                                              const Color(0xFFf5f5f5),
                                          child: SizedBox.expand(
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${(controller.cart.total - (controller.cart.total ~/ type) * type).toString().padLeft(2, "0")}/$type",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                    color: CustomColors.c0069c9,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    CustomPaint(
                                      size: Size(x * 0.45, x * 0.45),
                                      painter: MyPainter(
                                          count: (controller.cart.total -
                                              (controller.cart.total ~/ type) *
                                                  type),
                                          type: type),
                                    )
                                  ],
                                );
                              }),
                        ),
                        SizedBox(height: y * 0.028),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${CustomStrings.jami} ${controller.cart.total.toString().padLeft(2, "0")}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: CustomColors.c0069c9),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 3,
                        ),
                        SizedBox(height: y * 0.028),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            products.isNotEmpty
                                ? products[controller.cart.total ~/ type -
                                        (controller.cart.total ~/
                                            (type * products.length) *
                                            products.length)]
                                    .name
                                : "Zikr tanlang",
                            textAlign: TextAlign.center,
                            style:  TextStyle(

                                fontSize:products.isNotEmpty?products[controller.cart.total ~/ type -
                                    (controller.cart.total ~/
                                        (type * products.length) *
                                        products.length)]
                                    .name.length<15? 35: products[controller.cart.total ~/ type -
                                    (controller.cart.total ~/
                                        (type * products.length) *
                                        products.length)]
                                    .name.length < 30 ? 30 : null:35,
                                fontFamily: "Bekshire",
                                color: CustomColors.c0069c9),
                          ),
                        ),
                        const SizedBox(height: 35),
                        SizedBox(
                          height: x * 0.35,
                          width: x * 0.35,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              LayoutBuilder(builder: (context, constraints) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 40),
                                  width: controller.isChanged
                                      ? constraints.maxWidth * 0.9
                                      : constraints.maxWidth * 0.85,
                                  height: controller.isChanged
                                      ? constraints.maxWidth * 0.9
                                      : constraints.maxWidth * 0.85,
                                  curve: controller.isChanged
                                      ? Curves.linear
                                      : Curves.linear,
                                  onEnd: () {
                                    if (counter == 1) {
                                      controller.changed();
                                    }
                                    counter = 0;
                                  },
                                  child: Controls(
                                    audioPlayer: _audioPlayer,
                                    controller: controller,
                                    type: type,
                                    hasSound: controller.hasSound,
                                    counter: () {
                                      counter = 1;
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
