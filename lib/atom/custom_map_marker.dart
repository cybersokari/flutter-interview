import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';

class CustomMapMarker extends StatelessWidget {
  const CustomMapMarker({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      padding: const EdgeInsets.all(14),
      child: child ??
          SvgPicture.asset(
            Assets.iconsBuildingLine,
          ),
    );
  }
}
