import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/models/appointmentClear.dart';
import 'package:mobilehairdresser_app/services/appointment_service.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../services/user_service.dart';
import 'login_page.dart';

class Appointments extends StatefulWidget {
  Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {

  List<dynamic> _appointments = [];
  bool loading = true;

  Future<void> _getAppointments() async {
  ApiResponse response = await getAppointments();
  if(response.error == null) {
    setState(() {
      _appointments = response.data as List<dynamic>;
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

@override
  void initState() {
    _getAppointments();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return loading? const Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Randevularım"),
        
        
      ),
      body: Container(
        color: primaryColor,
        child: _appointments.length == 0? Text("Henüz Randevunuz Yok.", style: TextStyle(fontSize: 32),)
         :ListView.builder(
        itemCount: _appointments.length,
        itemBuilder: (BuildContext context, index) {
        AppointmentClear appointments = _appointments[index];
        return getCard(appointments.workerName,appointments.date,appointments.workingHour,appointments.adress,appointments.service,appointments.text,appointments.isAccept);
      }),)
      


      
    );

  }

  Widget getCard(workerName, date, workingHour, adress, service, text, isAccept){
      return Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          ),
        margin: EdgeInsets.all(12.0),
        
        child: ListTile(
          tileColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
            Row(
              children: [
                 Icon(Icons.people, color: Colors.black,),
                 Text("$workerName")
                
              ],
            ),
             Row(
              children: [
                 Icon(Icons.date_range, color: Colors.black,),
                 Text("$date || $workingHour")
                
              ],
            ),
             Row(
              children: [
                 Icon(Icons.location_on, color: Colors.black,),
                 Text("$adress")
                
              ],
            ),
            Row(
              children: [
                 Icon(Icons.design_services, color: Colors.black,),
                 Text("$service")
                
              ],
            ),
            Row(
              children: [
                 Icon(Icons.edit, color: Colors.black,),
                 text == null ? Text(" ") : Text("$text")
                
              ],
            ),

            Container(
              
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isAccept== 0 ? Colors.blueAccent : isAccept==1 ? Colors.green : Colors.red,
              ),
              
              child: isAccept== 0 ? Center(child: Text("Bekliyor", style: TextStyle(color: Colors.white),)) : isAccept == 1 ? Center(child: Text("Onaylandı", style: TextStyle(color: Colors.white))) : Center(child: Text("Reddedildi", style: TextStyle(color: Colors.white))),
                        ),


            
    
            
    
    
          ]),
        ),
        
      );
    }
}