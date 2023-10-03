import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final Color color;
  final bool selected;
  final Function() onTap;

  const ColorContainer({
    super.key,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            )),
      ),
    );
  }
}
