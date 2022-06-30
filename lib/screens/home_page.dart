

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/api_response.dart';
import 'package:mobilehairdresser_app/models/appointment.dart';
import 'package:mobilehairdresser_app/models/user.dart';
import 'package:mobilehairdresser_app/models/user_adress.dart';
import 'package:mobilehairdresser_app/models/worker.dart';
import 'package:mobilehairdresser_app/screens/appointments_page.dart';
import 'package:mobilehairdresser_app/screens/loading_page.dart';
import 'package:mobilehairdresser_app/screens/login_page.dart';
import 'package:mobilehairdresser_app/screens/user_adress_edit_page.dart';
import 'package:mobilehairdresser_app/screens/user_adress_page.dart';
import 'package:mobilehairdresser_app/services/user_service.dart';
import 'package:mobilehairdresser_app/services/worker_service.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

User? user;
bool loading = true;
String sehir = "";


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
                 height: MediaQuery.of(context).size.height,
                 width: MediaQuery.of(context).size.width,
                 decoration: const BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.vertical(
                     top: Radius.circular(30),
                     
                   ),
                 ),
                 child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,),
                      child: Container(
                        child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           
                             
                          Text("Hoşgeldin, ${user!.name}", style: primaryTextStyle(),),
                           IconButton(onPressed: () {
                             logout().then((value) => { Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Loading()), (route) => false)});},
                            icon: const Icon(Icons.logout), color: primaryColor,)


                         ],

                         
                   ),
                      ),
                    ),

                    Container(
                height: 250,
                decoration: const BoxDecoration(
                image: DecorationImage(
                image: AssetImage("images/mainLogo.png"),
                fit: BoxFit.scaleDown,
                    ),
                  ),
                ),

                     SizedBox(height: 50,),
                     Text('Menü', style: TextStyle (
                       fontWeight: FontWeight.bold,
                       fontSize: 24,
                       ),
                       ),
                      
                       SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>UserAdressPage()));
                          }, child: Text("Adres Seç")),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>Appointments()));
                          }, child: Text("Randevularım")),
                        ),

         
                 ]
                 ),
                 ),
               
              
            ),
    );
  }




  
}


