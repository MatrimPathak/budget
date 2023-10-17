import 'package:budget/firestore.dart';
import 'package:budget/models/categorymodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactionmodel.dart';
import '../widgets/widgets.dart';

class UpdatePage extends StatefulWidget {
  final String id;
  final String name;
  final String amount;
  final String category;
  final String type;
  final String notes;
  final Timestamp timestamp;
  const UpdatePage({
    super.key,
    required this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.type,
    required this.notes,
    required this.timestamp,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String parseAmount(double amount) {
    return NumberFormat.decimalPatternDigits(
      locale: "en_IN",
      decimalDigits: 2,
    ).format(amount);
  }

  String type = "Expense";
  String category = "Food";
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    type = widget.type;
    category = widget.category;
    dateTime = widget.timestamp.toDate();
  }

  @override
  Widget build(BuildContext context) {
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

    print(DateFormat('dd/MM/yyyy').format(widget.timestamp.toDate()));
    print(DateFormat('hh:hh a').format(widget.timestamp.toDate()));

    Future<void> addTransaction(
      String name,
      String amount,
      String notes,
      DateTime dateTime,
    ) async {
      if (name == "") return;
      if (amount == "") return;
      if (notes == "") return;

      Firestore.updateTransaction(
        TransactionModel(
          name: name,
          amount: amount,
          type: type,
          category: category,
          notes: notes,
          timestamp: Timestamp.fromDate(dateTime),
        ),
        widget.id,
      ).then((value) {
        Navigator.pop(context);
      });
    }

    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController notesController = TextEditingController();

    @override
    void dispose() {
      titleController.dispose();
      amountController.dispose();
      notesController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "UPDATE TRANSACTION",
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: type == "Expense"
                    ? Colors.red.shade200
                    : Colors.green.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                getIconDataFromCategory(category),
                size: 50,
                color: type == "Expense"
                    ? Colors.red.shade700
                    : Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormLabel(label: "TYPE"),
                      Row(
                        children: [
                          TypeButton(
                            type: "Expense",
                            selected: type == "Expense" ? true : false,
                            onTap: () {
                              setState(() {
                                type = "Expense";
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          TypeButton(
                            type: "Income",
                            selected: type == "Income" ? true : false,
                            onTap: () {
                              setState(() {
                                type = "Income";
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const FormLabel(label: "CATEGORY"),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: StreamBuilder<List<CategoryModel>>(
                          stream: Firestore.readcategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Some error occured"),
                              );
                            }
                            if (snapshot.hasData) {
                              final categoryData = snapshot.data;
                              if (categoryData!.isEmpty) {
                                return const AddCategoryButton();
                              }
                              return SizedBox(
                                height: 35,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 10);
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryData.length + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == 0) {
                                      return const AddCategoryButton();
                                    }
                                    final categoryItem =
                                        categoryData[index - 1];
                                    return CategoryTile(
                                      color: categoryItem.color,
                                      category: categoryItem.name,
                                      selected: category == categoryItem.name
                                          ? true
                                          : false,
                                      onTap: () {
                                        setState(() {
                                          setState(() {
                                            category = categoryItem.name;
                                          });
                                        });
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                            return const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const FormLabel(label: "DATE"),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              ).then((value) {
                                setState(() {
                                  dateTime = value!;
                                });
                              }),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(dateTime),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                setState(() {
                                  if (value == null) return;
                                  dateTime = DateTime(
                                    dateTime.year,
                                    dateTime.month,
                                    dateTime.day,
                                    value.hour,
                                    value.minute,
                                  );
                                });
                              }),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  DateFormat('hh:hh a').format(dateTime),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const FormLabel(label: "TITLE"),
                      FormTextField(
                        label: "Title",
                        text: widget.name,
                        controller: titleController,
                        textInputType: "name",
                      ),
                      const SizedBox(height: 10),
                      const FormLabel(label: "AMOUNT"),
                      FormTextField(
                        label: "Amount",
                        text: widget.amount,
                        controller: amountController,
                        textInputType: "number",
                      ),
                      const SizedBox(height: 10),
                      const FormLabel(label: "NOTES"),
                      FormTextField(
                        label: "Notes",
                        text: widget.notes,
                        controller: notesController,
                        textInputType: "multiline",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            AddButton(
              text: "Update Transaction",
              onTap: () {
                addTransaction(
                  titleController.text.trim() != ""
                      ? titleController.text.trim()
                      : widget.name,
                  amountController.text.trim() != ""
                      ? amountController.text.trim()
                      : widget.amount,
                  notesController.text.trim() != ""
                      ? notesController.text.trim()
                      : widget.notes,
                  dateTime,
                );
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}
