import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/models/working_hour.dart';
import 'package:mobilehairdresser_app/screens/note_page.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../services/user_service.dart';
import '../services/worker_service.dart';
import 'login_page.dart';

class WorkingHoursPage extends StatefulWidget {

  String adress;
  final int? workerId;
  int serviceId;
  DateTime dateTime;



  WorkingHoursPage(this.workerId,this.adress,this.serviceId,this.dateTime);

  @override
  State<WorkingHoursPage> createState() => _WorkingHoursPageState(workerId,adress,serviceId,dateTime);
}

class _WorkingHoursPageState extends State<WorkingHoursPage> {


  int? workerId;
  String adress;
  int serviceId;
  DateTime dateTime;

  _WorkingHoursPageState(this.workerId,this.adress,this.serviceId,this.dateTime);


  bool loading = true;
  List<dynamic> _workingHoursList = [];



  Future<void> _getWorkingHours(int? id, DateTime dateTime) async {
  ApiResponse response = await getWorkingHours(id,dateTime);
  if(response.error == null) {
    setState(() {
      _workingHoursList = response.data as List<dynamic>;
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
    // TODO: implement initState
    _getWorkingHours(workerId,dateTime);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return loading? const Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Saat Seçiniz"),
      ),
      body: Container(
        color: primaryColor,
        child: _workingHoursList.length == 0? Text("Uygun Saat Yok", style: TextStyle(fontSize: 32),)
         : ListView.builder(                
           itemCount: _workingHoursList.length,
           itemBuilder: (BuildContext context, index) {
           WorkingHours workingHours = _workingHoursList[index];
           return Container(
             child: getCard(workingHours.isActive,workingHours.hours,workingHours.id)
           );
           }),
                            
      )
      );
  }


  Widget getCard(bool? isActive, String? hours, int? workingHoursId){
    return Container(
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
              child: Icon(Icons.timelapse, color: Colors.white,),
            ),

            const SizedBox(width: 10,),
            Text(hours!),
    
            const SizedBox(width: 20,),

            TextButton(
              
              child: isActive! ? Text("Seç", style: const TextStyle(color: Colors.white),) : Text("Dolu", style: const TextStyle(color: Colors.black),),
              
              style: ButtonStyle(
              backgroundColor: isActive ? MaterialStateColor.resolveWith((states) => Colors.orange) : MaterialStateColor.resolveWith((states) => Colors.grey),
              padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                
    )
  )
              ),
              onPressed: () {
               isActive ? Navigator.push(context, MaterialPageRoute(builder:(context)=>NotePage(workerId, adress,serviceId,dateTime,workingHoursId)))
               : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lütfen uygun bir saat seçiniz.')));
              }
              ),
    
            
    
    
          ]),
        ),
        
      );
    
  }
}