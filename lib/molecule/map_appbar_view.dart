import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';

class MapAppbarView extends StatefulWidget {
  const MapAppbarView({
    super.key,
    this.animationDelay = const Duration(milliseconds: 1000),
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  final Duration animationDelay;
  final Duration animationDuration;

  @override
  State<MapAppbarView> createState() => _MapAppbarViewState();
}

class _MapAppbarViewState extends State<MapAppbarView>
    with SingleTickerProviderStateMixin {
  final _flex1 = 5, _flex2 = 1, _flex3 = .2;

  late final AnimationController _scaleAnimationController =
      AnimationController(
    duration: widget.animationDuration,
    vsync: this,
  );
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _scaleAnimationController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(
        widget.animationDelay, () => _scaleAnimationController.forward());
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = Scaffold.of(context).appBarMaxHeight! * .4;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      var width1 = (_flex1 * width) / (_flex1 + _flex2 + _flex3);
      var width2 = (_flex2 * width) / (_flex1 + _flex2 + _flex3);
      var space = (_flex3 * width) / (_flex1 + _flex2 + _flex3);
      return Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: width1,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(Assets.iconsSearchLine),
                      const SizedBox(
                        width: 8,
                      ),
                      const AutoSizeText(
                        maxLines: 1,
                        minFontSize: 4,
                        "Akwa Ibom",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: space,
          ),
          Stack(
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  height: height,
                  width: width2,
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: SvgPicture.asset(Assets.iconsFilterLine),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
