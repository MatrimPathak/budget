import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final Function() onTap;
  final bool selected;
  final String color;

  const CategoryTile({
    super.key,
    required this.category,
    required this.onTap,
    required this.selected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    MaterialColor getColorFromString(String color) {
      if (color == "Purple") return Colors.purple;
      if (color == "Indigo") return Colors.indigo;
      if (color == "Blue") return Colors.blue;
      if (color == "Green") return Colors.green;
      if (color == "Yellow") return Colors.yellow;
      if (color == "Orange") return Colors.orange;
      if (color == "Red") return Colors.red;
      return Colors.purple;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? getColorFromString(color).shade700
              : Colors.grey.shade700,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
