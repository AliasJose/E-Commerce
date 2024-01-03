
 
 
import 'dart:convert';

List<Product> postFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromMap(x)));

class Product{
  Product({
    required this.Id,
    required this.catid,
    required this.productname,
    required this.price,
    required this.image,
    required this.description,
  });

  int Id;
  int catid;
  String productname;
  double price;
  String image;
  String description;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        Id: json["id"],
        catid: json["catid"],
        productname: json["productname"],
        price: json["price"].toDouble(),
        image: json["image"],
        description: json["description"]
      );
}









