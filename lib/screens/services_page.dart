import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/services.dart';
import 'package:mobilehairdresser_app/screens/select_date_page.dart';

import '../models/api_response.dart';
import '../services/user_service.dart';
import '../services/worker_service.dart';
import 'login_page.dart';

class ServicePage extends StatefulWidget {
  final int? workerId;
  String adress;
  ServicePage(this.workerId,this.adress);

  @override
  State<ServicePage> createState() => _ServicePageState(workerId,adress);
}

class _ServicePageState extends State<ServicePage> {
  int? workerId;
  String adress;
  List _serviceList = [];
  bool loading = true;
  _ServicePageState(this.workerId,this.adress);




  void _getServiceList(int? id) async {
  ApiResponse response = await getServiceList(id);
  if(response.error == null) {
    setState(() {
      _serviceList = response.data as List<dynamic>;
      loading = loading? !loading : loading;
      print(_serviceList.length);
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
    _getServiceList(workerId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loading? const Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Servis Seçiniz"),
      ),
      body: Container(
        color: primaryColor,
        child: _serviceList.length == 0? Text("Uygun Servis Yok", style: TextStyle(fontSize: 32),)
         : ListView.builder(                
           itemCount: _serviceList.length,
           itemBuilder: (BuildContext context, index) {
           Services services = _serviceList[index];
           return Container(
             child: getCard(services.serviceName, services.price, services.id)
           );
           }),
                            
      )
      );
  }


  Widget getCard(serviceName, price,serviceId){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:(context)=>SelectDate(workerId,adress,serviceId)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
          ),
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
              child: Icon(Icons.select_all, color: Colors.white,),
            ),

    
            Text("$serviceName"),

            

            Text("$price TL"),
    
            const SizedBox(width: 20,),

            IconButton(onPressed: () {
              
              
            }, icon: const Icon(Icons.bookmark_add,))
    
            
    
    
          ]),
        ),
        
      ),
    );
  }
}

