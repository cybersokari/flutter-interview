import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sokari_flutter_interview/organism/gallery.dart';

import '../atom/counter_text.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late Timer buyCountTimer;
  late Timer rentCountTimer;
  late int buyCount;
  late int rentCount;
  bool expand = false;
  final _homeBackgroundGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Colors.orange.withOpacity(0.8),
      Colors.orange.withOpacity(0.3),
      Colors.orange.withOpacity(0.0),
    ],
  );

  @override
  void initState() {
    super.initState();
    buyCount = 401;
    rentCount = 1050;
    Future.delayed(const Duration(seconds: 1), () {
      startGalleryAnimation();
    });
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
  }

  @override
  void dispose() {
    buyCountTimer.cancel();
    rentCountTimer.cancel();
    super.dispose();
  }

  double galleryPosition = -1000;

  void startGalleryAnimation() => galleryPosition = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(gradient: _homeBackgroundGradient),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: height / 6.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, Bukola",
                      style: TextStyle(color: Colors.grey.shade600),
                    ).animate().fadeIn(duration: 3.seconds),
                    const AutoSizeText("let's select your",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                            ))
                        .animate(delay: 500.milliseconds)
                        .slideY(duration: 1500.milliseconds, begin: 1.5)
                        .fadeIn(duration: 3000.milliseconds, begin: 0),
                    const AutoSizeText("perfect place",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                            ))
                        .animate(delay: 750.milliseconds)
                        .slideY(duration: 1500.milliseconds, begin: 1.5)
                        .fadeIn(duration: 3000.milliseconds),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                LayoutBuilder(builder: (cxt, constraint) {
                  final itemSize = constraint.maxWidth * .45;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: itemSize,
                          width: itemSize,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AnimatedDefaultTextStyle(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
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
                                      fontSize: 30)),
                              const Text(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                "offers",
                              ),
                              const Spacer(),
                            ],
                          ),
                        )
                            .animate(delay: const Duration(milliseconds: 1000))
                            .scaleXY(
                                begin: 0,
                                end: 1,
                                duration: const Duration(milliseconds: 1000)),
                      ),
                      ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: Container(
                                height: itemSize,
                                width: itemSize,
                                padding: const EdgeInsets.all(25),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      "RENT",
                                    ),
                                    const Spacer(),
                                    AnimatedCounterText(
                                        resizeDuration:
                                            const Duration(milliseconds: 1000),
                                        duration:
                                            const Duration(milliseconds: 100),
                                        value: rentCount,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 30)),
                                    const Text(
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      "offers",
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ))
                          .animate(delay: const Duration(milliseconds: 1000))
                          .scaleXY(
                              begin: 0,
                              end: 1,
                              duration: const Duration(milliseconds: 1000)),
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
            duration: const Duration(milliseconds: 2000),
            child: Gallery(
              height: height / 1.7,
            ),
          )
        ],
      ),
    );
  }
}
