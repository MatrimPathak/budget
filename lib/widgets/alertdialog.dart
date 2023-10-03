import 'package:budget/models/transactionmodel.dart';
import 'package:budget/widgets/formfield.dart';
import 'package:budget/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    void addTransaction(
      String title,
      String amount,
      String type,
      String category,
      String date,
      String notes,
    ) {
      if (title == "") return;
      if (amount == "") return;
      if (type == "") return;
      if (category == "") return;
      if (date == "") return;
      if (notes == "") return;

      // transactions.add(
      //   {
      //     "name": title,
      //     "amount": amount,
      //     "type": type,
      //     "category": category,
      //     "date": date,
      //     "notes": notes,
      //   },
      // );
    }

    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController notesController = TextEditingController();

    return Container(
      height: 500,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "ADD NEW TRANSACTION",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.fastfood,
                        size: 35,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const FormLabel(label: "TITLE"),
                    FormTextField(
                      label: "Title",
                      controller: titleController,
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    const FormLabel(label: "AMOUNT"),
                    FormTextField(
                      label: "Amount",
                      controller: amountController,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    const FormLabel(label: "TYPE"),
                    FormTextField(
                      label: "Type",
                      controller: typeController,
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    const FormLabel(label: "CATEGORY"),
                    FormTextField(
                      label: "Category",
                      controller: categoryController,
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    const FormLabel(label: "DATE"),
                    FormTextField(
                      label: "Date",
                      controller: dateController,
                      textInputType: TextInputType.datetime,
                    ),
                    const SizedBox(height: 10),
                    const FormLabel(label: "NOTES"),
                    FormTextField(
                      label: "Notes",
                      controller: notesController,
                      textInputType: TextInputType.multiline,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              DialogButton(
                onTap: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.white24,
                foregroundColor: Colors.white70,
                text: "Cancel",
              ),
              const SizedBox(width: 10),
              DialogButton(
                onTap: () {
                  addTransaction(
                    titleController.text.trim(),
                    amountController.text.trim(),
                    typeController.text.trim(),
                    categoryController.text.trim(),
                    dateController.text.trim(),
                    notesController.text.trim(),
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                text: "Add",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
