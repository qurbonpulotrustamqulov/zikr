import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

import '../../../../core/controllers/zikr_controller.dart';
import '../../../../services/constants/colors.dart';
import '../../../../services/constants/images.dart';
import 'new_morph.dart';

class Controls extends StatefulWidget {
  const Controls(
      {super.key,
        required this.counter,
        required this.audioPlayer,
        required this.controller,
        required this.type, required this.hasSound});

  final void Function() counter;
  final AudioPlayer audioPlayer;
  final ZikrController controller;
 final  int type;
  final int hasSound;

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  void startAudio() {
    if (products.isNotEmpty) {
      widget.controller.changed();
      widget.controller.addToCard(
        product: products.firstWhere((element) =>
        element.name ==
            products[widget.controller.cart.total ~/ widget.type -
                (widget.controller.cart.total ~/
                    (widget.type * products.length) *
                    products.length)]
                .name),
        quantity: 1,
      );
    }
    if(widget.hasSound == 1){
      widget.audioPlayer.setAsset("assets/sound/effect.mp3");
      widget.audioPlayer.play();
    }
    else if(widget.hasSound == 3){
      Vibration.vibrate(duration: 100);
    }
    widget.counter();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: widget.audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (playing == false || processingState == ProcessingState.completed) {
          return GestureDetector(
            onTap: startAudio,
            child: CircleAvatar(
              backgroundColor: CustomColors.c0069c9,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: NewMorph(
                  innerShadow: false,
                  outerShadow: true,
                  highlightColor: Colors.white.withOpacity(0.05),
                  shadowColor: const Color(0xff000000).withOpacity(0.3),
                  backgroundColor: const Color(0xFFf5f5f5),
                  child: const SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.all(45.0),
                        child: Image(
                          image: CustomImages.add,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (playing == true) {
          return GestureDetector(
            onTap: widget.audioPlayer.pause,
            child: CircleAvatar(
              backgroundColor: CustomColors.c0069c9,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: NewMorph(
                  innerShadow: false,
                  outerShadow: true,
                  highlightColor: Colors.white.withOpacity(0.05),
                  shadowColor: const Color(0xff000000).withOpacity(0.3),
                  backgroundColor: const Color(0xFFf5f5f5),
                  child: const SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.all(45.0),
                        child: Image(
                          image: CustomImages.add,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: widget.audioPlayer.play,
            child: CircleAvatar(
              backgroundColor: CustomColors.c0069c9,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: NewMorph(
                  innerShadow: false,
                  outerShadow: true,
                  highlightColor: Colors.white.withOpacity(0.05),
                  shadowColor: const Color(0xff000000).withOpacity(0.3),
                  backgroundColor: const Color(0xFFf5f5f5),
                  child: const SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.all(45.0),
                        child: Image(
                          image: CustomImages.add,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ),
          );
        }
      },
    );
  }
}