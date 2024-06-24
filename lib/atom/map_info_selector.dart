import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../generated/assets.dart';

class MapInfoSelector extends StatelessWidget {
  const MapInfoSelector({super.key, required this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: GestureDetector(
          onTap: onTap,
          child: Wrap(
            spacing: 8,
            direction: Axis.vertical,
            children: [
              _getInfoItem("Cosy Area", Assets.iconsFilterLine),
              _getInfoItem("Price", Assets.iconsFilterLine,
                  iconColor: Colors.orange),
              _getInfoItem("Infrastructure", Assets.iconsFilterLine),
              _getInfoItem("Without any layer", Assets.iconsFilterLine),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getInfoItem(String title, String iconPath, {Color? iconColor}) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          color: iconColor,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(title)
      ],
    );
  }
}
