import 'package:budget/models/categorymodel.dart';
import 'package:budget/models/transactionmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static Future createTransaction(TransactionModel transaction) async {
    final db = FirebaseFirestore.instance.collection("Transactions");

    final newTransaction = TransactionModel(
      id: transaction.id,
      name: transaction.name,
      amount: transaction.amount,
      category: transaction.category,
      type: transaction.type,
      date: transaction.date,
      notes: transaction.notes,
      timestamp: transaction.timestamp,
    ).toJson();

    try {
      await db.add(newTransaction);
    } catch (e) {
      print(e);
    }
  }

  static Future createDummyTransaction(TransactionModel transaction) async {
    final db = FirebaseFirestore.instance.collection("Dummy Transactions");

    final newTransaction = TransactionModel(
      id: transaction.id,
      name: transaction.name,
      amount: transaction.amount,
      category: transaction.category,
      type: transaction.type,
      date: transaction.date,
      notes: transaction.notes,
      timestamp: transaction.timestamp
    ).toJson();

    try {
      await db.add(newTransaction);
    } catch (e) {
      print(e);
    }
  }

  static Future createCategory(CategoryModel category) async {
    final db = FirebaseFirestore.instance.collection("Categories");

    final newCategory = CategoryModel(
      id: category.id,
      name: category.name,
      color: category.color,
    ).toJson();

    try {
      await db.add(newCategory);
    } catch (e) {
      print(e);
    }
  }

  static Stream<List<TransactionModel>> readTransactions() {
    final db = FirebaseFirestore.instance.collection("Transactions").orderBy(
          "timestamp",
          descending: true,
        );
    return db.snapshots().map((QuerySnapshot snapshot) => snapshot.docs
        .map((documentSnapshot) =>
            TransactionModel.fromSnapshot(documentSnapshot))
        .toList());
  }

  static Stream<List<CategoryModel>> readcategories() {
    final db = FirebaseFirestore.instance.collection("Categories");
    return db.snapshots().map((QuerySnapshot snapshot) => snapshot.docs
        .map((documentSnapshot) => CategoryModel.fromSnapshot(documentSnapshot))
        .toList());
  }

  static Future<void> removeTransaction(String documentId) async {
    await FirebaseFirestore.instance
        .collection("Transactions")
        .doc(documentId)
        .delete()
        .then((value) => print("Transaction Deleted"))
        .catchError((error) => print("Failed to delete transaction: $error"));
  }
}
