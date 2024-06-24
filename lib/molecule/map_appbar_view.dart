import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';

class MapAppbarView extends StatelessWidget {
  const MapAppbarView({
    super.key,
    this.animationDelay = const Duration(milliseconds: 1000),
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  final Duration animationDelay;
  final Duration animationDuration;

  final _flex1 = 5, _flex2 = 1, _flex3 = .2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      var width1 = (_flex1 * width) / (_flex1 + _flex2 + _flex3);
      var width2 = (_flex2 * width) / (_flex1 + _flex2 + _flex3);
      var space = (_flex3 * width) / (_flex1 + _flex2 + _flex3);
      return Row(
        children: [
          SizedBox(
            width: width1,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(Assets.iconsSearchLine),
                      const SizedBox(
                        width: 4,
                      ),
                      const Expanded(
                        child: AutoSizeText(
                          maxLines: 1,
                          minFontSize: 4,
                          "Akwa Ibom",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .scale(delay: animationDelay, duration: animationDuration),
              ],
            ),
          ),
          SizedBox(
            width: space,
          ),
          SizedBox(
            width: width2,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(Assets.iconsFilterLine),
                  ).animate().scale(
                      delay: animationDelay, duration: animationDuration),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
