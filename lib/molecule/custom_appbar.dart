import 'package:flutter/material.dart';

import 'landing_appbar_view.dart';
import 'map_appbar_view.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.isMap = false, this.height = 80});

  final bool isMap;
  final double height;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .05),
      child: isMap ? const MapAppbarView() : const LandingAppbarView(),
    ));
  }

  @override
  Size get preferredSize => Size(double.maxFinite, height);
}
