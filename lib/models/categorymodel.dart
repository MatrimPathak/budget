import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? id;
  final String name;
  final String color;

  const CategoryModel({
    this.id,
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "color": color,
    };
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> snapshot =
        documentSnapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: documentSnapshot.id,
      name: snapshot['name'],
      color: snapshot['color'],
    );
  }
}
