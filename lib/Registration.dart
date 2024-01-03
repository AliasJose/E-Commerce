import 'dart:convert';
import 'dart:developer';

import 'package:ecommerceapp/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LoginPage.dart';



class Registrationpage extends StatefulWidget {
  const Registrationpage({super.key,required this.title});
   
  final String title;


  @override


 State <Registrationpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();





  late bool _obscurePassword;
  late bool _autovalidate;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _autovalidate = false;
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  registration(String name, phone, address, username, password) async{
    try{
      print(username);
      print(password);
      var result;
      final Map<String,dynamic> Data = {
        'name': name,
        'phone': phone,
        'address': address,
        'username': username,
        'password': password,
      };
        final response = await http.post(Uri.parse('https://bootcamp.cyralearnings.com/registration.php'),
        body: Data
        );
        print(response.statusCode);
        if(response.statusCode==200){
          if(response.body.contains("success")){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Success")));
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return LoginPage(title: '',);
            },
            ));
          }
          else{
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Failed"))); 
          }
        }
        else{
          result = {log(json.decode(response.body)['error'].toString())};
          return result;
        }
    }
    catch (e) {
      log(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
             
      body: Center(
      child:SafeArea(
    

        minimum: const EdgeInsets.all(16),
        child: _buildLoginForm(),
      ),
      )
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
                    "Register Account",
                    textAlign:TextAlign.center ,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50,color: Color.fromARGB(255, 4, 1, 36),),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Complete your details",
                  textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: Color.fromARGB(255, 4, 1, 36),),                  ),
                              SizedBox(
              height: 90,
            ),

            TextFormField(
              decoration: InputDecoration(
                labelText: ' Name',
                filled: true,
                isDense: true,
              ),
              controller: _nameController,
              keyboardType: TextInputType.text,
              autocorrect: false,
               validator: (val) => _validateRequired(val!, 'name'),

            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: ' Phone',
                filled: true,
                isDense: true,
              ),
              controller: _phoneController,
              keyboardType: TextInputType.text,
              autocorrect: false,
               validator: (val) => _validateRequired(val!, 'phone'),

            ),
            SizedBox(
              height: 15,
            ),                        TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                filled: true,
                isDense: true,
              ),
              controller: _addressController,
              keyboardType: TextInputType.text,
              autocorrect: false,
               validator: (val) => _validateRequired(val!, 'address'),

            ),
            SizedBox(
              height: 15,
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
              height: 15,
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
              height: 20,
            ),
            
            

TextButton(
  onPressed: () async {
    final bool isValid = _key.currentState!.validate();
    if (isValid) {
      print("Form is valid");
      _key.currentState!.save();
      String name = _nameController.text;
      String phone = _phoneController.text;
      String address = _addressController.text;
      String username = _usernameController.text;
      String password = _passwordController.text;
      print("name = " + name);
      print("phone = " + phone);
      print("address = " + address);
      print("Username = " + username);
      print("password = " + password);
registration(name, phone, address, username, password);
      // Navigate to the HomePage

    }
  },
        child: const Text('Register'),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor:maincolor,
                                                   
                                shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),                    
            textStyle:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      SizedBox(
        height: 10,
      ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Do you have an account? ",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                    width: 10
                  ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage(title: '',);
                      },
                    ));
                  },
                  
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 28,
                        color: maincolor,
                        // Color.fromARGB(255, 5, 1, 50),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? _validateRequired(String val, fieldName) {
    if (val == null || val == '') {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateusername(String value) {
    if (value == null || value == '') {
      return 'username is required';
    }
  

    var regex;
    if (!regex.hasMatch(value)) {
      return 'Enter valid username';
    }
    return null;
    
  }

  void _validateFormAndLogin() {
    // Get form state from the global key
    var formState = _key.currentState;

    // check if form is valid
    if (formState!.validate()) {
      print('Form is valid');
    } else {
      // show validation errors
      // setState forces our [State] to rebuild
      setState(() {
        _autovalidate = true;
      });
    }
  }
}