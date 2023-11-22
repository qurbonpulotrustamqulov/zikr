import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:untitled/core/controllers/zikr_controller.dart';
import 'package:untitled/core/providers/zikr_provider.dart';
import 'package:untitled/main.dart';
import 'package:untitled/presentation/pages/home_page/home_page_views/refresh_zikr.dart';
import 'package:untitled/presentation/pages/home_page/home_page_views/zikr_count.dart';
import 'package:untitled/presentation/pages/home_page/home_page_views/zikr_list.dart';
import 'package:untitled/services/constants/colors.dart';
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
    ScreenUtil.init(context);
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
                    height: 530.sp,
                    width: 380.sp,
                    decoration: BoxDecoration(
                      color: CustomColors.cf5f5f5,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.sp),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ///bosilganda zikrlar ro'yxatini ochib beruvchi tugma
                              ZikrList(
                                  controller: controller,
                                  controller1: controller1),
                              const Spacer(),

                              ///zikrlar sanog'ini o'zgartirish
                              ZikrCount(
                                  controller: controller,
                                  controller2: controller2),

                              ///zikr tovushini nazorat qilish
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

                              ///Zikr sanog'ini 0 ga qaytarish
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (controller.cart.items.isNotEmpty) {
                                        for (int i = 0;
                                        i < controller.cart.items.length;
                                        i++) {
                                          controller.cart.items[i].quantity = 0;
                                        }
                                      controller.cart.total = 0;
                                      }
                                    });
                                  },
                                  icon: const Image(
                                    image:
                                    AssetImage("assets/images/refresh.png"),
                                    width: 24,
                                  ))                            ],
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
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            products.isNotEmpty
                                ? products[controller.cart.total ~/ type -
                                        (controller.cart.total ~/
                                            (type * products.length) *
                                            products.length)]
                                    .name
                                : "Zikr tanlang",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: products.isNotEmpty
                                    ? products[controller.cart.total ~/ type -
                                                    (controller.cart.total ~/
                                                        (type *
                                                            products.length) *
                                                        products.length)]
                                                .name
                                                .length <
                                            15
                                        ? 35
                                        : products[controller.cart.total ~/
                                                            type -
                                                        (controller
                                                                .cart.total ~/
                                                            (type *
                                                                products
                                                                    .length) *
                                                            products.length)]
                                                    .name
                                                    .length <
                                                30
                                            ? 30
                                            : null
                                    : 35,
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
