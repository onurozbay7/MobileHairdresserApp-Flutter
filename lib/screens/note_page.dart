import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/models/api_response.dart';
import 'package:mobilehairdresser_app/screens/home_page.dart';
import 'package:mobilehairdresser_app/screens/main_page.dart';
import 'package:mobilehairdresser_app/services/appointment_service.dart';
import 'package:cool_alert/cool_alert.dart';
import '../constant.dart';

class NotePage extends StatefulWidget {

  String adress;
  final int? workerId;
  int serviceId;
  DateTime dateTime;
  int? workingHoursId;

  NotePage(this.workerId,this.adress,this.serviceId,this.dateTime,this.workingHoursId);


  

  @override
  State<NotePage> createState() => _NotePageState(workerId,adress,serviceId,dateTime,workingHoursId);
}

 
  

class _NotePageState extends State<NotePage> {

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  int? workerId;
  String adress;
  int serviceId;
  DateTime dateTime;
  int? workingHoursId;
  final TextEditingController? _noteController = TextEditingController();
  bool loading = false;

  _NotePageState(this.workerId,this.adress,this.serviceId,this.dateTime,this.workingHoursId);


  void _createAppointment() async {
    ApiResponse response = await createAppointment(workerId.toString(),dateTime.toString(),workingHoursId.toString(),adress,serviceId.toString(),_noteController!.text);
    if(response.error == null) {
      print(response.data);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Randevu Oluştur"),
      ),
      body:  Container(
        child: Column(
          
          children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Text("Eklemek istediğiniz bir not var mı ?"),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: _noteController,
                maxLines: 4, //or null 
                decoration: const InputDecoration(
                  labelText: "Notunuzu buraya giriniz..",
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.pinkAccent)),
  )
              ),
            
          ),

          loading ?const Center(child: CircularProgressIndicator(),)
              : SizedBox(
                width: 350,
                child: ElevatedButton(style: ElevatedButton.styleFrom(
                primary: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
                onPressed: () {
                   setState(() {
                  loading = true;
                  _createAppointment();
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Randevunuz Başarıyla Oluşturuldu.",
                    ).then((value) => Navigator.push(context, MaterialPageRoute(builder:(context)=> MainPage())));
                  
                });
                }, child: Text("Randevu Oluştur")),
              ),

        ]),
      )
    );
  }
}