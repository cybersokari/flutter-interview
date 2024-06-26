import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../generated/assets.dart';

class MapInfoSelector extends StatelessWidget {
  const MapInfoSelector(
      {super.key,
      required this.onTap,
      required this.screenHeight,
      required this.screenWidth});
  final Function()? onTap;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: screenHeight * .2,
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getInfoItem("Cosy areas", Assets.iconsShieldLine),
              _getInfoItem("Price", Assets.iconsWalletLine,
                  color: Colors.orange),
              _getInfoItem("Infrastructure", Assets.iconsShoppingBasketLine),
              _getInfoItem("Without any layer", Assets.iconsStackLine),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getInfoItem(String title, String iconPath, {color = Colors.grey}) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          SvgPicture.asset(
            height: screenHeight * .02,
            iconPath,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(
            width: 8,
          ),
          AutoSizeText(
            title,
            minFontSize: 4,
            style: TextStyle(color: color),
          )
        ],
      ),
    );
  }
}
