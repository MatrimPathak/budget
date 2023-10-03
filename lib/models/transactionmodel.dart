import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? id;
  final String name;
  final String amount;
  final String category;
  final String type;
  // final String date;
  final String notes;
  final Timestamp timestamp;

  const TransactionModel({
    this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.type,
    // required this.date,
    required this.notes,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "amount": amount,
      "category": category,
      "type": type,
      // "date": date,
      "notes": notes,
      "timestamp": timestamp
    };
  }

  factory TransactionModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> snapshot =
        documentSnapshot.data() as Map<String, dynamic>;
    return TransactionModel(
      id: documentSnapshot.id,
      name: snapshot['name'],
      amount: snapshot['amount'],
      type: snapshot['type'],
      category: snapshot['category'],
      // date: snapshot['date'],
      notes: snapshot['notes'],
      timestamp: snapshot['timestamp'],
    );
  }
}
