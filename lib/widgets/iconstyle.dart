import 'package:flutter/material.dart';

class IconStyle extends StatelessWidget {
  final IconData iconData;
  final Color backgroundColor;
  final Color iconColor;
  final BoxShape boxShape;

  const IconStyle({
    super.key,
    required this.iconData,
    required this.backgroundColor,
    required this.iconColor,
    required this.boxShape,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(boxShape == BoxShape.rectangle ? 15 : 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: boxShape,
        borderRadius:
            boxShape == BoxShape.rectangle ? BorderRadius.circular(10) : null,
      ),
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }
}
