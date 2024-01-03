import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginPage.dart';
import 'Provider.dart/Cart_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerece App',
      theme: ThemeData(
      
        primarySwatch:  Colors.grey,
      ),
            home: const LoginPage(title: ''),
    );
  }
}



                   
