import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/screens/working_hours_page.dart';

import '../constant.dart';

class SelectDate extends StatefulWidget {

  String adress;
  int? workerId;
  int serviceId;



  SelectDate(this.workerId,this.adress,this.serviceId);

  @override
  State<SelectDate> createState() => _SelectDateState(workerId,adress,serviceId);
}

class _SelectDateState extends State<SelectDate> {

  DateTime dateTime = new DateTime.now();

  int? workerId;
  String adress;
  int serviceId;


  Future<Null> _selectdata(BuildContext context) async{

  final DateTime? picked = await showDatePicker(context: context, initialDate: dateTime, firstDate: new DateTime.now(), lastDate: new DateTime(2030));
if(picked!=null && picked!=dateTime)
  {
    print('Date Selected:${dateTime.toString()}');
    setState(() {
      dateTime = picked;
    });
  }
}


 _SelectDateState(this.workerId,this.adress,this.serviceId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarih Seçiniz"),
        backgroundColor: primaryColor,
      ),

      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(style: ElevatedButton.styleFrom(
                primary: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
                onPressed: () {
                  _selectdata(context);
                }, child: Text("Tarih Seç")),
              ),

            SizedBox(height: 20,),

            Text("'Seçilen Tarih:${dateTime.toString().split(" ").first}'"),

            SizedBox(height: 20,),

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(style: ElevatedButton.styleFrom(
                primary: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>WorkingHoursPage(workerId, adress,serviceId,dateTime)));
                }, child: Text("Uygun Saatleri Gör")),
              ),
          ],
        ),
      ),
    );
  }
}