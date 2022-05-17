import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/user_adress.dart';
import 'package:mobilehairdresser_app/screens/create_adress_page.dart';
import 'package:mobilehairdresser_app/screens/login_page.dart';
import 'package:mobilehairdresser_app/services/user_service.dart';
import 'package:mobilehairdresser_app/services/user_adress_service.dart';

import '../models/api_response.dart';

class UserAdressPage extends StatefulWidget {
  UserAdressPage({Key? key}) : super(key: key);

  @override
  State<UserAdressPage> createState() => _UserAdressPageState();
}

class _UserAdressPageState extends State<UserAdressPage> {

  bool loading = true;
  List<dynamic> _userAdress = [];


  void _deleteUserAdress(int adresId) async {
    ApiResponse response = await deleteUserAdress(adresId);
    if(response.error == null) {
    
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



  

  Future<void> _getUserAdress() async {
  ApiResponse response = await getUserAdress();
  if(response.error == null) {
    setState(() {
      _userAdress = response.data as List<dynamic>;
      loading = loading? !loading : loading;
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
refreshState() {
  _getUserAdress();
}

@override
  void initState() {
    // TODO: implement initState
    _getUserAdress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading? const Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        title: const Text("Adres Seçimi"),
        actions: [
          IconButton(icon:Icon(Icons.add_circle_outline),
          onPressed:() => Navigator.push(context,MaterialPageRoute(builder: (context) => CreateAdressPage()),).then((value) => refreshState()),
      ),
        ],
        
        
      ),
      body: Container(child: ListView.builder(
        itemCount: _userAdress.length,
        itemBuilder: (BuildContext context, index) {
        UserAdress userAdress = _userAdress[index];
        return getCard(userAdress.adresName, userAdress.il, userAdress.adres, userAdress.id);
      }),)
      


      
    );
  }

  Widget getCard(adresName, il, adres,id){
    return GestureDetector(
      onTap: () {
        Navigator.pop(context,il);
      },
      child: Card(
        margin: EdgeInsets.all(12.0),
        
        child: ListTile(
          tileColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            
            Container(
              width: 40,
              height: 40,
              decoration:  BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(60/2),
              ),
              child: Icon(Icons.location_city_rounded, color: Colors.white,),
            ),
    
            const SizedBox(width: 20,),
    
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(adresName + " - " + il),
                Text(adres),
              ],
            ),
    
            const SizedBox(width: 20,),

            IconButton(onPressed: () {
              _deleteUserAdress(id);
              refreshState();
            }, icon: const Icon(Icons.delete))
    
            
    
    
          ]),
        ),
        
      ),
    );
  }
}