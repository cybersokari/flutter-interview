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

  @override
  void initState() {
    super.initState();
    _navigationAnimationController = AnimationController(
        vsync: this, value: 100, duration: const Duration(milliseconds: 50));

    Future.delayed(const Duration(milliseconds: 3000), () {
      _navigationAnimationController.reverse();
    });
  }

  @override
  void dispose() {
    _navigationAnimationController.dispose();
    super.dispose();
  }

  final mapMakerModel = MapMarkerModel();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        isMap: showMapView,
        height: height * .1,
      ),
      body: IndexedStack(
        index: showMapView ? 1 : 0,
        children: [const LandingView(), MapView(mapMakerModel)],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 32, right: 32),
        child: AnimatedBuilder(
            animation: _navigationAnimationController,
            builder: (context, childWidget) {
              return Transform.translate(
                offset: Offset(0, 200 * _navigationAnimationController.value),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    padding: const EdgeInsetsDirectional.only(
                        top: 4, bottom: 4, end: 8),
                    // height: 50,
                    color: Colors.black87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: showMapView
                                  ? Colors.orange
                                  : Colors.transparent),
                          child: IconButton(
                            // highlightColor: Theme.of(context).highlightColor,
                            onPressed: () => setState(() {
                              showMapView = true;
                            }),
                            icon: SvgPicture.asset(
                              Assets.iconsSearchFilled,
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent),
                          child: SvgPicture.asset(
                            Assets.iconsChatFilled,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: showMapView
                                  ? Colors.transparent
                                  : Colors.orange),
                          child: IconButton(
                              // highlightColor: Theme.of(context).highlightColor,
                              onPressed: () => setState(() {
                                    showMapView = false;
                                  }),
                              icon: SvgPicture.asset(
                                Assets.iconsHomeFilled,
                              )),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent),
                          child: SvgPicture.asset(
                            Assets.iconsHeartFilled,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent),
                          child: SvgPicture.asset(
                            Assets.iconsProfile,
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
        duration: const Duration(milliseconds: 700),
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
