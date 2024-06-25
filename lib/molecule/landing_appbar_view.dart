import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';

class LandingAppbarView extends StatefulWidget {
  const LandingAppbarView({
    super.key,
    this.locationAnimationDelay = const Duration(milliseconds: 1000),
    this.avatarRevealAnimationDuration = const Duration(milliseconds: 1000),
  });

  final Duration locationAnimationDelay;
  final Duration avatarRevealAnimationDuration;

  @override
  State<LandingAppbarView> createState() => _LandingAppbarViewState();
}

class _LandingAppbarViewState extends State<LandingAppbarView> {
  bool animateAppBarItemSize = false;
  bool showAppBarText = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.locationAnimationDelay, () {
      if (mounted) {
        setState(() {
          animateAppBarItemSize = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final appBarHeight = Scaffold.of(context).appBarMaxHeight!;
    const leadingContentColor = Color.fromRGBO(165, 149, 126, 1);
    return Row(
      children: [
        AnimatedContainer(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          width: animateAppBarItemSize ? width / 2.3 : width / 8,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          duration: const Duration(milliseconds: 1300),
          onEnd: () => setState(() {
            showAppBarText = true;
          }),
          child: AnimatedOpacity(
            opacity: showAppBarText ? 1 : 0,
            duration: const Duration(milliseconds: 2000),
            child: Row(
              children: [
                LayoutBuilder(builder: (cnt, constraints) {
                  return SvgPicture.asset(
                    colorFilter: const ColorFilter.mode(
                        leadingContentColor, BlendMode.srcIn),
                    Assets.iconsLocationPin,
                    height: appBarHeight / 10,
                    width: 15,
                  );
                }),
                const SizedBox(
                  width: 4,
                ),
                const Expanded(
                  child: AutoSizeText(
                    maxLines: 1,
                    minFontSize: 4,
                    "Akwa Ibom",
                    style: TextStyle(color: leadingContentColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        CircleAvatar(
          radius: 20,
          foregroundImage: Image.asset(
            Assets.imagesImg5,
          ).image,
        ).animate().scale(
            delay: widget.locationAnimationDelay,
            duration: widget.avatarRevealAnimationDuration),
      ],
    );
  }
}
