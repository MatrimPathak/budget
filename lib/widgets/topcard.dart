import 'package:budget/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  final String balance;
  final String totalIncome;
  final String totalExpense;
  const TopCard({
    super.key,
    required this.balance,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              "B A L A N C E\n₹ $balance",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    IconStyle(
                      iconData: Icons.arrow_downward,
                      backgroundColor: Colors.green.shade200,
                      iconColor: Colors.green.shade700,
                      boxShape: BoxShape.circle,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "INCOME\n₹ $totalIncome",
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconStyle(
                      iconData: Icons.arrow_upward,
                      backgroundColor: Colors.red.shade200,
                      iconColor: Colors.red.shade700,
                      boxShape: BoxShape.circle,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "EXPENSE\n₹ $totalExpense",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
