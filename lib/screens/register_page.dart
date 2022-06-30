import 'package:mobilehairdresser_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool loading = false;
  final TextEditingController 
   nameController = TextEditingController(),
   emailController = TextEditingController(),
   phoneController = TextEditingController(),
   passwordController = TextEditingController(),
   passwordConfirmController = TextEditingController();

   void _registerUser() async {
    ApiResponse response = await register(nameController.text, phoneController.text, emailController.text, passwordController.text);
    if(response.error == null) {
      print(response.data);
      _saveAndRedirectHome(response.data as User);
    }
    else {
      setState(() {
        loading = !loading;
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
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
  }


  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            TextFormField(
              controller: nameController,
              validator: (val) => val!.isEmpty ? 'Invalid name' : null,
              decoration: kInputDecoration("Name & Surname",const Icon(Icons.people))
            ),

            const SizedBox(height: 20,),

            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              validator: (val) => val!.length != 11 ? 'Invalid phone' : null,
              decoration: kInputDecoration("Phone", const Icon(Icons.phone))
            ),

            const SizedBox(height: 20,),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (val) => val!.isEmpty ? 'Invalid email adress' : null,
              decoration: kInputDecoration("Email", const Icon(Icons.email))
            ),

            const SizedBox(height: 20,),

            TextFormField(
              obscureText: true,
              controller: passwordController,
              validator: (val) => val!.length < 6 ? 'Required at least 6 characters' : null,
              decoration: kInputDecoration("Password", const Icon(Icons.workspaces))
            ),

            const SizedBox(height: 20,),

            TextFormField(
              obscureText: true,
              controller: passwordConfirmController,
              validator: (val) => val != passwordController.text ? "Confirm password does not match" : null,
              decoration: kInputDecoration("Confirm Password", const Icon(Icons.workspaces))
            ),

            const SizedBox(height: 20,),

            loading ?const Center(child: CircularProgressIndicator(),)
            :
            kTextButton("Register", (){
              if(formkey.currentState!.validate()){
                setState(() {
                  loading = true;
                  _registerUser();
                });
              }
            }),

            const SizedBox(height: 10,),

            kLoginRegisterHint('Already have an account? ', "Login", (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
            })
          ],
        ),
      ),
      
    );
  }
}