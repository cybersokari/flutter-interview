import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sokari_flutter_interview/atom/inkwell_button.dart';
import 'package:sokari_flutter_interview/extensions/number_duration_extensions.dart';
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool showMapView = false;
  final _greyButtonColor = Colors.grey.withOpacity(.7);
  late AnimationController _navigationAnimationController;
  bool showMapInfoSelector = false;
  final mapItemsVisibilityDelay = 1200.milliseconds;

  late final AnimationController _scaleAnimationController =
      AnimationController(
    duration: 1000.milliseconds,
    vsync: this,
  );
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _scaleAnimationController,
    curve: Curves.fastOutSlowIn,
  );

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

  Widget _navButton(String iconPath, double screenHeight, Function()? onTap,
      {bool active = false}) {
    final iconButtonSize = screenHeight * .025;
    const iconPadding = EdgeInsets.all(10);
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: active ? Colors.orange : Colors.black),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: onTap,
          highlightColor: Colors.white,
          splashColor: Colors.white54,
          child: Padding(
            padding: iconPadding,
            child: SvgPicture.asset(
              width: iconButtonSize,
              iconPath,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bottomNavHorizontalPadding = width * .11;
    final navBackground = Colors.black.withOpacity(.9);
    final favIconHeight = height * .02;
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
              return Transform.translate(
                offset: Offset(
                  0,
                  200 *
                      _navigationAnimationController
                          .drive(CurveTween(curve: Curves.fastOutSlowIn))
                          .value,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: navBackground,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _navButton(
                            active: showMapView,
                            Assets.iconsSearchFilled,
                            height,
                            () => setState(() {
                                  showMapView = true;
                                })),
                        _navButton(Assets.iconsChatFilled, height, null),
                        _navButton(
                          active: !showMapView,
                          Assets.iconsHomeFilled,
                          height,
                          () => setState(() {
                            showMapView = false;
                          }),
                        ),
                        _navButton(Assets.iconsHeartFilled, height, null),
                        _navButton(Assets.iconsProfile, height, null),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: width * .1, right: width * .01),
        child: AnimatedOpacity(
          opacity: showMapView ? 1 : 0,
          duration: mapItemsVisibilityDelay,
          onEnd: () {
            if (showMapView) {
              mapMakerModel.showText();
            } else {
              mapMakerModel.hide();
            }
          },
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
                                _scaleAnimationController.forward();
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
                                child: SvgPicture.asset(
                                    height: favIconHeight,
                                    Assets.iconsStackLine)),
                          ),
                        ),
                      ),
                      ScaleTransition(
                        alignment: Alignment.bottomLeft,
                        scale: _scaleAnimation,
                        child: MapInfoSelector(
                          onTap: () => setState(() {
                            showMapInfoSelector = false;
                            _scaleAnimationController.reverse();
                            if (mapMakerModel.markerState == MarkerState.text) {
                              return mapMakerModel.showIcon();
                            }
                          }),
                          screenHeight: height,
                          screenWidth: width,
                        ),
                      ),
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
                        child: SvgPicture.asset(
                            height: favIconHeight, Assets.iconsNavigation)),
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
                      SvgPicture.asset(
                          height: favIconHeight, Assets.iconsHambugerLine),
                      SizedBox(
                        width: width * .015,
                      ),
                      const AutoSizeText(
                        minFontSize: 4,
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
