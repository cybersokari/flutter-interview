import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sokari_flutter_interview/atom/inkwell_button.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';
import 'package:sokari_flutter_interview/model/map_marker_model.dart';
import 'package:sokari_flutter_interview/molecule/custom_appbar.dart';
import 'package:sokari_flutter_interview/pages/landing.dart';
import 'package:sokari_flutter_interview/pages/map.dart';

import 'atom/map_info_selector.dart';
import 'molecule/faded_index_stack.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool showMapView = false;
  final _greyButtonColor = Colors.grey.withOpacity(.7);
  late AnimationController _navigationAnimationController;
  bool showMapInfoSelector = false;
  final mapItemsVisibilityDelay = 1200.milliseconds;

  @override
  void initState() {
    super.initState();
    _navigationAnimationController = AnimationController(
        vsync: this, value: 100, duration: 1000.milliseconds);

    Future.delayed(4.seconds, () {
      _navigationAnimationController.reverse();
    });
  }

  @override
  void dispose() {
    _navigationAnimationController.dispose();
    mapMakerModel.dispose();
    super.dispose();
  }

  final mapMakerModel = MapMarkerModel();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bottomNavHorizontalPadding = width * .11;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        isMap: showMapView,
        height: height * .1,
      ),
      body: FadeIndexedStack(
        duration: 1.seconds,
        index: showMapView ? 1 : 0,
        children: [const LandingView(), MapView(mapMakerModel)],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: height * 0.02,
            left: bottomNavHorizontalPadding,
            right: bottomNavHorizontalPadding),
        child: AnimatedBuilder(
            animation: _navigationAnimationController,
            builder: (context, childWidget) {
              final iconButtonSize = height * .025;
              const iconPadding = EdgeInsets.all(10);
              return Transform.translate(
                offset: Offset(0, 200 * _navigationAnimationController.value),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    // height: 50,
                    color: Colors.black87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          onPressed: () => setState(() {
                            showMapView = true;
                          }),
                          icon: Container(
                            padding: iconPadding,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    showMapView ? Colors.orange : Colors.black),
                            child: SvgPicture.asset(
                              width: iconButtonSize,
                              Assets.iconsSearchFilled,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: null,
                          icon: Container(
                            padding: iconPadding,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: SvgPicture.asset(
                              width: iconButtonSize,
                              Assets.iconsChatFilled,
                            ),
                          ),
                        ),
                        IconButton(
                            highlightColor: Colors.white,
                            splashColor: Colors.white,
                            onPressed: () => setState(() {
                                  showMapView = false;
                                }),
                            icon: Container(
                              padding: iconPadding,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: showMapView
                                      ? Colors.black
                                      : Colors.orange),
                              child: SvgPicture.asset(
                                width: iconButtonSize,
                                Assets.iconsHomeFilled,
                              ),
                            )),
                        IconButton(
                          icon: Container(
                            padding: iconPadding,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: SvgPicture.asset(
                              width: iconButtonSize,
                              Assets.iconsHeartFilled,
                            ),
                          ),
                          onPressed: null,
                        ),
                        IconButton(
                          onPressed: null,
                          icon: Container(
                            padding: iconPadding,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: SvgPicture.asset(
                              width: iconButtonSize,
                              Assets.iconsProfile,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: showMapView ? 1 : 0,
        duration: mapItemsVisibilityDelay,
        onEnd: () {
          if (showMapView) {
            mapMakerModel.showText();
          } else {
            mapMakerModel.hide();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWellButton(
                            onTap: () {
                              setState(() {
                                showMapInfoSelector = true;
                                if (mapMakerModel.markerState ==
                                    MarkerState.icon) {
                                  mapMakerModel.showText();
                                }
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _greyButtonColor),
                                child: SvgPicture.asset(Assets.iconsStackLine)),
                          ),
                        ),
                      ),
                      MapInfoSelector(
                        onTap: () => setState(() {
                          showMapInfoSelector = false;
                          if (mapMakerModel.markerState == MarkerState.text) {
                            return mapMakerModel.showIcon();
                          }
                        }),
                      ).animate(target: showMapInfoSelector ? 1 : 0).scaleXY(
                          end: 1,
                          begin: 0,
                          curve: Curves.fastOutSlowIn,
                          alignment: Alignment.bottomLeft,
                          duration: const Duration(milliseconds: 1000)),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Transform.rotate(
                    angle: 45,
                    child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: _greyButtonColor),
                        child: SvgPicture.asset(Assets.iconsNavigation)),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 8),
                  color: _greyButtonColor,
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.iconsHambugerLine),
                      const SizedBox(
                        width: 4,
                      ),
                      const AutoSizeText(
                        "list of variants",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
