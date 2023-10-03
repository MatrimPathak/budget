import 'package:budget/firestore.dart';
import 'package:budget/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatefulWidget {
  final String id;
  final String name;
  final String amount;
  final String category;
  final String type;
  final String date;
  final String notes;
  final Timestamp timestamp;

  const TransactionTile({
    super.key,
    required this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    required this.notes,
    required this.timestamp,
  });

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    MaterialColor getCategoryColorFromCategory(String category) {
      if (category == "Food") return Colors.purple;
      if (category == "Rent") return Colors.indigo;
      if (category == "Salary") return Colors.blue;
      if (category == "Groceries") return Colors.green;
      if (category == "Travel") return Colors.yellow;
      if (category == "Shopping") return Colors.indigo;
      if (category == "Personal") return Colors.red;
      return Colors.cyan;
    }

    Color getIconBackgroundColorFromCategory(String type) {
      if (type == "Expense") return Colors.red.shade200;
      if (type == "Income") return Colors.green.shade200;
      return Colors.red.shade200;
    }

    Color getIconColorFromType(String type) {
      if (type == "Expense") return Colors.red.shade700;
      if (type == "Income") return Colors.green.shade700;
      return Colors.red.shade700;
    }

    Color getTextColorFromType(String type) {
      if (type == "Expense") return Colors.red.shade700;
      if (type == "Income") return Colors.green.shade700;
      return Colors.red.shade700;
    }

    IconData getIconDataFromCategory(String category) {
      if (category == "Salary") return Icons.currency_rupee;
      if (category == "Food") return Icons.fastfood;
      if (category == "Groceries") return Icons.shopping_basket;
      if (category == "Personal") return Icons.people;
      if (category == "Shopping") return Icons.shopping_cart;
      if (category == "Travel") return Icons.bike_scooter;
      if (category == "Recharge") return Icons.five_g;
      return Icons.warning;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
              // onPressed: (context) => Firestore.removeTransaction(widget.id),
              onPressed: (context) => {},
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.edit,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
              onPressed: (context) => Firestore.removeTransaction(widget.id),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.delete,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconStyle(
                      iconData: getIconDataFromCategory(widget.category),
                      backgroundColor:
                          getIconBackgroundColorFromCategory(widget.type),
                      iconColor: getIconColorFromType(widget.type),
                      boxShape: BoxShape.rectangle,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: getCategoryColorFromCategory(
                                          widget.category)
                                      .shade800,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: getCategoryColorFromCategory(
                                            widget.category)
                                        .shade200,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                padding: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: getCategoryColorFromCategory(
                                          widget.category)
                                      .shade800,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.category,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹ ${NumberFormat.decimalPatternDigits(locale: "en_IN", decimalDigits: 2).format(
                            double.parse(widget.amount),
                          )}",
                          style: TextStyle(
                            color: getTextColorFromType(widget.type),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat(
                                  'MMM dd, yyyy ${isExpanded ? '\nhh:hh a' : ''}')
                              .format(widget.timestamp.toDate()),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                isExpanded
                    ? const SizedBox(height: 10)
                    : const SizedBox.shrink(),
                isExpanded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Notes:"),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              widget.notes,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
