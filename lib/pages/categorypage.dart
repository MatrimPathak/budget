import 'package:budget/models/categorymodel.dart';
import 'package:budget/widgets/colorcontainer.dart';
import 'package:flutter/material.dart';

import '../firestore.dart';
import '../widgets/widgets.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String color = "Purple";
  @override
  Widget build(BuildContext context) {
    Future<void> addcategory(
      String name,
      String color,
    ) async {
      if (name == "") return;

      Firestore.createCategory(
        CategoryModel(
          name: name,
          color: color,
        ),
      );
    }

    TextEditingController nameController = TextEditingController();
    @override
    void dispose() {
      nameController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD NEW CATEGORY"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel(label: "AMOUNT"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ColorContainer(
                          color: Colors.purple,
                          selected: color == "Purple" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Purple";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.indigo,
                          selected: color == "Indigo" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Indigo";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.blue,
                          selected: color == "Blue" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Blue";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.green,
                          selected: color == "Green" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Green";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.yellow,
                          selected: color == "Yellow" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Yellow";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.orange,
                          selected: color == "Orange" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Orange";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.red,
                          selected: color == "Red" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Red";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.pink,
                          selected: color == "Pink" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Pink";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.brown,
                          selected: color == "Brown" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Brown";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.cyan,
                          selected: color == "Cyan" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Cyan";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.lime,
                          selected: color == "Lime" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Lime";
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        ColorContainer(
                          color: Colors.teal,
                          selected: color == "Teal" ? true : false,
                          onTap: () {
                            setState(() {
                              color = "Teal";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  const FormLabel(label: "NAME"),
                  FormTextField(
                    label: "Name",
                    controller: nameController,
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
            AddButton(
              text: "Add Category",
              onTap: () {
                addcategory(
                  nameController.text.trim(),
                  color,
                );
                Navigator.pop(context);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}
