import 'package:flutter/material.dart';

class SegmentGraph extends StatelessWidget {
  final int rentWidth;
  final int groceriesWidth;
  final int travelWidth;
  final int foodWidth;
  final int personalWidth;
  const SegmentGraph({
    super.key,
    required this.rentWidth,
    required this.groceriesWidth,
    required this.travelWidth,
    required this.foodWidth,
    required this.personalWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: rentWidth,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Flexible(
                  flex: groceriesWidth,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                ),
                Flexible(
                  flex: foodWidth,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                    ),
                  ),
                ),
                Flexible(
                  flex: travelWidth,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                    ),
                  ),
                ),
                Flexible(
                  flex: personalWidth,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("Rent"),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("Groceries"),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("Food"),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("Travel"),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("Personal"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
