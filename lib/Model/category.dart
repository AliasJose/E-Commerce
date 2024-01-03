
import 'dart:convert';

List<Category> postFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromMap(x)));

class Category {
  int? id;
  String? category;

  Category({
    required this.id,
    required this.category,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        category: json["category"],
      );
}





                   
