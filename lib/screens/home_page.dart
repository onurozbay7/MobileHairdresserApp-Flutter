

import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/api_response.dart';
import 'package:mobilehairdresser_app/models/user.dart';
import 'package:mobilehairdresser_app/models/user_adress.dart';
import 'package:mobilehairdresser_app/screens/loading_page.dart';
import 'package:mobilehairdresser_app/screens/login_page.dart';
import 'package:mobilehairdresser_app/screens/user_adress_page.dart';
import 'package:mobilehairdresser_app/services/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

User? user;
bool loading = true;
String sehir = "Şehir Seç";

void _awaitReturnAdressFromUserAdressPage(BuildContext context) async {
  final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => UserAdressPage(),));

  setState(() {
    sehir = result;
  });
}



void getUser() async {
  ApiResponse response = await getUserDetail();
  if(response.error == null) {
    setState(() {
      user = response.data as User;
      loading = false;
    });
  }
  else if(response.error == unauthorized) {
    logout().then((value) => {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage(),), (route) => false)
    });
  }

  else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response.error}')));
  }
}

@override
  void initState() {
    getUser();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return loading? const Center(child: CircularProgressIndicator(),) : Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left:20.0, right: 20.0),
        child: Column(
          children: [
           const SizedBox(height: 50,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               
                 
              Text("Hoşgeldin, ${user!.name}"),

              Text(sehir),

              
                   
               IconButton(onPressed: () {
                 _awaitReturnAdressFromUserAdressPage(context);
               }, icon: const Icon(Icons.location_city_rounded,))
             ],
           ),

           const SizedBox(height: 50,),

          GestureDetector(
          onTap: (){
            logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Loading()), (route) => false)
            });
          },
          child: Text('Press to logout, ${user!.name}'),
        ),

          ],
        ),
      ),
      
     /* body: Center(
        child: GestureDetector(
          onTap: (){
            logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Loading()), (route) => false)
            });
          },
          child: Text('Press to logout, ${user!.name}'),
        ),
      ),*/
    );
  }
}


