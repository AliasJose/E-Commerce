import 'dart:convert';
import 'dart:developer';
import 'package:ecommerceapp/Constants.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'Registration.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late bool _obscurePassword;
  late bool _autovalidate;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _autovalidate = false;
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log("isloggedin = " + isLoggedIn.toString());
    if (isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Homepage(title: '')));
    }
  }

  login(String username, String password) async {
    try {
      print(username);
      print(password);

      final Map<String, dynamic> loginData = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('http://bootcamp.cyralearnings.com/login.php'),
        body: loginData,
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("login successfully completed");
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("username", username);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Homepage(title: '');
            },
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed")));
        }
      } else {
        var result = {log(json.decode(response.body)['error'].toString())};
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: _buildLoginForm(),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Welcome Back",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: maincolor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Login with your username and password",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: maincolor),
            ),
            SizedBox(
              height: 100,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'User Name',
                filled: true,
                isDense: true,
              ),
              controller: _usernameController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              validator: (val) => _validateRequired(val!, 'username'),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                isDense: true,
              ),
              obscureText: _obscurePassword,
              controller: _passwordController,
              validator: (val) => _validateRequired(val!, 'Password'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () async {
                final bool isValid = _key.currentState!.validate();
                if (isValid) {
                  print("Form is valid");
                  _key.currentState!.save();
                  String username = _usernameController.text;
                  String userpassword = _passwordController.text;
                  print("Username = " + username);
                  print("User password = " + userpassword);
                  login(username, userpassword);
                  // Navigate to the HomePage
                }
              },
              child: const Text('Login'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                      height: 10
                      ),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: TextStyle(fontSize: 20),
                  ),
                   SizedBox(
                      width: 10
                      ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Registrationpage(title: '',);
                        },
                      ));
                    },
                    
                    child: Text(
                      "Go to Register",
                      style: TextStyle(
                          fontSize: 28,
                          color: maincolor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String? _validateRequired(String val, fieldName) {
    if (val == null || val.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateUsername(String value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    // Add additional validation logic here
    return null;
  }
}
