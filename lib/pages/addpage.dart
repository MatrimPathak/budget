import 'package:budget/firestore.dart';
import 'package:budget/models/categorymodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactionmodel.dart';
import '../widgets/widgets.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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
  Widget build(BuildContext context) {
    IconData getIconDataFromCategory(String category) {
      if (category == "Salary") return Icons.currency_rupee;
      if (category == "Food") return Icons.fastfood;
      if (category == "Groceries") return Icons.shopping_basket;
      if (category == "Personal") return Icons.people;
      if (category == "Shopping") return Icons.shopping_cart;
      if (category == "Travel") return Icons.bike_scooter;
      if (category == "Recharge") return Icons.five_g;
      if (category == "Subscriptions") return Icons.subscriptions;
      return Icons.warning;
    }

    Future<void> addTransaction(
      String name,
      String amount,
      String notes,
      DateTime dateTime,
    ) async {
      if (name == "") return;
      if (amount == "") return;
      if (notes == "") return;

      Firestore.createTransaction(
        TransactionModel(
          name: name,
          amount: amount,
          type: type,
          category: category,
          // date: "date",
          notes: notes,
          timestamp: Timestamp.fromDate(dateTime),
        ),
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
          "ADD NEW TRANSACTION",
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
                                  DateFormat('hh:mm a').format(dateTime),
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
                        controller: titleController,
                        textInputType: "name",
                      ),
                      const SizedBox(height: 10),
                      const FormLabel(label: "AMOUNT"),
                      FormTextField(
                        label: "Amount",
                        controller: amountController,
                        textInputType: "number",
                      ),
                      const SizedBox(height: 10),
                      const FormLabel(label: "NOTES"),
                      FormTextField(
                        label: "Notes",
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
              text: "Add Transaction",
              onTap: () {
                addTransaction(
                  titleController.text.trim(),
                  amountController.text.trim(),
                  notesController.text.trim(),
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
