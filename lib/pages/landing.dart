import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sokari_flutter_interview/extensions/number_duration_extensions.dart';
import 'package:sokari_flutter_interview/model/animation_model.dart';
import 'package:sokari_flutter_interview/molecule/expanding_box_widget.dart';
import 'package:sokari_flutter_interview/organism/gallery.dart';

import '../atom/counter_text.dart';
import '../atom/slide_the_fade_widget.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView>
    with SingleTickerProviderStateMixin {
  late Timer buyCountTimer;
  late Timer rentCountTimer;
  late int buyCount;
  late int rentCount;
  bool expand = false;
  final _homeBackgroundGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Colors.orange.withOpacity(0.4),
      Colors.orange.withOpacity(0.4),
      Colors.white.withOpacity(0.1),
    ],
  );

  @override
  void initState() {
    super.initState();
    buyCount = 401;
    rentCount = 1050;
    buyCountTimer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      int tick = timer.tick;
      if (tick < 1035) {
        setState(() {
          buyCount = tick;
        });
      } else {
        timer.cancel();
      }
    });
    rentCountTimer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      int tick = timer.tick;
      if (tick < 2213) {
        setState(() {
          rentCount = tick;
        });
      } else {
        timer.cancel();
      }
    });
    Future.delayed(400.milliseconds, () => instantAnimationsStarted = true);
  }

  bool instantAnimationsStarted = false;

  @override
  void dispose() {
    buyCountTimer.cancel();
    rentCountTimer.cancel();
    super.dispose();
  }

  final animationModel = AnimationModel();
  double galleryPosition = -1000;

  void startGalleryAnimation(double height) => galleryPosition = -height * .23;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const countFontSize = 34.0;
    const countInfoFontSize = 14.0;
    const rentTextColor = Color.fromRGBO(165, 149, 126, 1);
    const greetingTextColor = Color.fromRGBO(35, 34, 32, 1);
    const greetingTextSize = 35.0;
    return Container(
      decoration: BoxDecoration(gradient: _homeBackgroundGradient),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: height / 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedOpacity(
                      opacity: 1,
                      duration: 3.seconds,
                      child: Text(
                        "Hi, Bukola",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 18),
                      ),
                    ),
                    const SlideAndFadeWidget(
                      child: Text("let's select your",
                          style: TextStyle(
                            color: greetingTextColor,
                            fontSize: greetingTextSize,
                          )),
                    ),
                    SlideAndFadeWidget(
                      delay: 1200.milliseconds,
                      child: const Text("perfect place",
                          style: TextStyle(
                            color: greetingTextColor,
                            fontSize: greetingTextSize,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                LayoutBuilder(builder: (cxt, constraint) {
                  final itemSize = constraint.maxWidth * .475;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ExpandingBox(
                        size: itemSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AnimatedDefaultTextStyle(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: countInfoFontSize),
                              duration: Duration(milliseconds: 1000),
                              child: Text(
                                "BUY",
                              ),
                            ),
                            const Spacer(),
                            AnimatedCounterText(
                                resizeDuration:
                                    const Duration(milliseconds: 1000),
                                duration: const Duration(milliseconds: 1000),
                                value: buyCount,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: countFontSize)),
                            const Text(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: countInfoFontSize),
                              "offers",
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      ExpandingBox(
                        size: itemSize,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              style: TextStyle(
                                  color: rentTextColor,
                                  fontSize: countInfoFontSize),
                              "RENT",
                            ),
                            const Spacer(),
                            AnimatedCounterText(
                                resizeDuration:
                                    const Duration(milliseconds: 1000),
                                duration: const Duration(milliseconds: 100),
                                value: rentCount,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: rentTextColor,
                                    fontSize: countFontSize)),
                            const Text(
                              style: TextStyle(
                                  color: rentTextColor,
                                  fontSize: countInfoFontSize),
                              "offers",
                            ),
                            const Spacer(),
                          ],
                        ),
                        onAnimationEnd: () {
                          startGalleryAnimation(height);
                        },
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          AnimatedPositioned(
            bottom: galleryPosition,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 1200),
            curve: Curves.fastOutSlowIn,
            child: Gallery(
              animationModel: animationModel,
              height: height * .7,
            ),
            onEnd: () => animationModel.moveSlider(),
          )
        ],
      ),
    );
  }
}
