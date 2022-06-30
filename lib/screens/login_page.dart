import 'dart:convert';

import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/api_response.dart';
import 'package:mobilehairdresser_app/screens/home_page.dart';
import 'package:mobilehairdresser_app/screens/main_page.dart';
import 'package:mobilehairdresser_app/screens/register_page.dart';
import 'package:mobilehairdresser_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(_emailController.text, _passwordController.text);
    if(response.error == null) {
      _saveAndRedirectHome(response.data as User);
    }
    else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _saveAndRedirectHome(User user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  MainPage()), (route) => false);
  }




 /* bool _isLoading = false;

  signIn(String email, String password) async {
    String url = "http://192.168.1.115/api/user/login";
    Uri serviceUri = Uri.parse(url);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email": email, "password": password};
    var jsonResponse;
    var response = await http.post(serviceUri, body: body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("Response status: ${response.statusCode}");
      print("Response status: ${response.body}");

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        sharedPreferences.setString(
            "token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });

      print("Response status: ${response.body}");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            Container(
                height: 250,
                decoration: const BoxDecoration(
                image: DecorationImage(
                image: AssetImage("images/mainLogo.png"),
                fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (val) => val!.isEmpty ? 'Invalid email adress' : null,
              decoration: kInputDecoration("Email", const Icon(Icons.email))
            ),

            const SizedBox(height: 10,),

            TextFormField(
              obscureText: true,
              controller: _passwordController,
              validator: (val) => val!.length < 6 ? 'Required at least 6 characters' : null,
              decoration: kInputDecoration("Password", const Icon(Icons.password))
            ),

            const SizedBox(height: 10,),

            loading? const Center(child: CircularProgressIndicator(),)
            :
            kTextButton("Login", (){
              if(formkey.currentState!.validate()){
                setState(() {
                  loading = true;
                  _loginUser();
                });
              }
            }),

            const SizedBox(height: 10,),

            kLoginRegisterHint('Dont have an account? ', "Register", (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RegisterPage()), (route) => false);
            })
          ],
        ),
      ),
      
    );
  }
}
