import 'dart:convert';
import 'dart:developer';
import 'package:badges/badges.dart' as badges;
import 'package:ecommerceapp/CartPage.dart';
import 'package:ecommerceapp/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Categorypage.dart';
import 'LoginPage.dart';
import 'Model/Product.dart';
import 'Model/category.dart';
import 'OrderDetails.dart';
import 'Provider.dart/Cart_provider.dart';
import 'Viewproducts.dart';
import 'package:http/http.dart' as http;

Future<List<Category>>fetchCategories()async {
    
      final response = await http.post(Uri.parse('http://bootcamp.cyralearnings.com/getcategories.php'));
      
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<Category>((json) => Category.fromMap(json))
            .toList();
      } else {
        throw Exception('Failed to load category');
      }
    
  }

   Future<List<Product>> fetchPost() async {
                                                    
  final response =  await http.post
  (Uri.parse('http://bootcamp.cyralearnings.com/view_offerproducts.php'));
                                                        
  if (response.statusCode == 200) {
   final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromMap(json)).toList();
  } else {
 throw Exception('Failed to load album');
 }
  }

class Homepage extends StatefulWidget {
  final String title;

  Homepage({super.key,required this.title});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Category>> futureCategories;
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    // futureCategories = fetchCategories();
    futureProducts = fetchPost();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'E-COMMERCE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: maincolor,
      ),
      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 38),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 30),
            Text(
              "E-COMMERCE",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: maincolor,
              ),
            ),
            SizedBox(height: 30),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 10),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 30,
                color: maincolor,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 25, color:maincolor),
              ),
              trailing: Icon(Icons.arrow_forward_ios),iconColor:maincolor,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage(title: '')),
                );
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: badges.Badge(
                  showBadge:
                      //  true,
                      context.read<Cart>().getItems.isEmpty ? false : true,
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                  badgeContent: Text(
                    context.watch<Cart>().getItems.length.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  child:  Icon(
                Icons.shopping_cart,
                size: 30,
                color:maincolor,
              )),
              
              title: Text(
                "Cart Page",
                style: TextStyle(fontSize: 25, color: maincolor),
              ),
              trailing: Icon(Icons.arrow_forward_ios),iconColor:maincolor,
              onTap: ()  {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(
                Icons.list_alt,
                size: 30,
                color: maincolor,
              ),
              title: Text(
                "Order Details",
                style: TextStyle(fontSize: 25, color:maincolor),
              ),
              trailing: Icon(Icons.arrow_forward_ios),iconColor:maincolor,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetails(title: '')),
                );
              },
            ),
            SizedBox(height: 10),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 10),
            Divider(height: 1, thickness: 1),
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                size: 30,
                color: Colors.redAccent,
              ),
              title: Text(
                "LogOut",
                style: TextStyle(fontSize: 25, color: maincolor),
              ),
              trailing: Icon(Icons.arrow_forward_ios),iconColor:maincolor,
                           onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(title: '',)),
                );
              },
            ),
            Divider(height: 1, thickness: 1),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Category',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: maincolor,
              ),
            ),
          ),



          
          Container(
            
            height: 100,
            child: FutureBuilder(
         future: fetchCategories(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
            //  log("length ==" + snapshot.data!.length.toString());
             return Container(
               height: 80,
               //  color: Colors.amber,
               child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemCount:snapshot.data!.length,
                 itemBuilder: (context, index) {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: InkWell(
                       onTap: () {
                         // log("clicked");
                        
                         Navigator.push(context, MaterialPageRoute(
                           builder: (context) {
                             return Category_productsPage(
                                // catid: ,catname: ;
                               catid: snapshot.data![index].id!,
                               catname: snapshot.data![index].category!,
                             );
                           },
                         ));
                       },
                       child: Container(
                         padding: EdgeInsets.all(15),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color:Colors.grey,
                         ),
                         child: Center(
                           child: Text(
                             snapshot.data![index].category!,
                             // "Cateogry name",
                             style: TextStyle(
                                 // color: maincolor,
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold),
                           ),
                         ),
                       ),
                     ),
                   );
                 },
               ),
             );
           } else {
             return Center(child: CircularProgressIndicator());
           }
         }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Offer Products",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
               color: maincolor,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No products available.'));
                  } else {
                    List<Product> products = snapshot.data!;

                    return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                           
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => viewproduct(
                                  product: product,
                                   id: product.Id,
                                          name: product.productname,
                                          image: "http://bootcamp.cyralearnings.com/products/${product.image}",
                                          price: product.price.toString(),
                                          description: product.description, title: '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 3 / 4,
                                  child: Image.network(
                                    "http://bootcamp.cyralearnings.com/products/${product.image}",
                                    fit: BoxFit.cover,
                                    height: 150,
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return Center(child: Text('Image not available'));
                                    },
                                  ),
                                ),
                                SizedBox(height: 9),
                                Text(
                                  "${product.productname}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Rs.${product.price}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
