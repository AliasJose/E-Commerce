
import 'dart:developer';

import 'package:ecommerceapp/Constants.dart';
import 'package:ecommerceapp/HomePage.dart';
import 'package:ecommerceapp/Model/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'Provider.dart/Cart_provider.dart';






class viewproduct extends StatelessWidget {
  final String title;
   final String name;
  final String price;
  final String image;
  final String description;
  int id;
  final Product product;
  viewproduct(
      {
        required this.title,
      required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.description, required this.product});
  @override
  Widget build(BuildContext context) {
    log("id = " + id.toString());
    log("name = " + name);
    log("price = " + price);
    log("desc = " + description.toString());
    log("image = " + image.toString());
    
return Scaffold(
   

      body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all    (16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:30
            ),

     Positioned(
                          left: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Homepage(title: '',);
                                  },
                                ));
                              },
                            ),
                          )),
                       AspectRatio(
    aspectRatio: 2/ 3,
    child: Image.network(
      "http://bootcamp.cyralearnings.com/products/${product.image}",
      fit: BoxFit.cover,
      height: 150,
    ),
  ),
 Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      padding: EdgeInsets.all(16),
      color: Color.fromARGB(255, 244, 244, 247),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            "${product.productname}".toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Rs.${product.price}".toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${product.description}",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    ),
  ],
),


 

  Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: maincolor),
                  child: Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),



                              ],
        ),
      ),
      ),
      bottomSheet: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  log("price ==" + double.parse(price).toString());

                  var existingItemCart = context
                      .read<Cart>()
                      .getItems
                      .firstWhereOrNull((element) => element.id == id);
                  // log("existingItemCart----" + existingItemCart.toString());
                  if (existingItemCart != null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: Text("This item already in cart",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ));
                  } else {
                    context
                        .read<Cart>()
                        .addItem(id, name, double.parse(price), 1, image);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: Text("Added to cart !!!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ));
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: maincolor),
                  child: Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
    );
      
  }
}







 
