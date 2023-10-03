import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  final String type;
  final bool selected;
  final Function() onTap;

  const TypeButton({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor(String type) {
      if (type == "Expense") {
        if (selected) {
          return Colors.red.shade700;
        }
      } else if (type == "Income") {
        if (selected) {
          return Colors.green.shade700;
        }
      }
      return Colors.grey.shade700;
    }

    Color getForegroundColor(String type) {
      if (type == "Expense") {
        if (selected) {
          return Colors.red.shade100;
        }
      } else if (type == "Income") {
        if (selected) {
          return Colors.green.shade100;
        }
      }
      return Colors.grey.shade100;
    }

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: getBackgroundColor(type),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                color: getForegroundColor(type),
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
