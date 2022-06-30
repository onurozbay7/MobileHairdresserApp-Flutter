import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/services.dart';
import 'package:mobilehairdresser_app/models/worker.dart';
import 'package:mobilehairdresser_app/screens/services_page.dart';
import 'package:mobilehairdresser_app/services/worker_service.dart';
import '../models/api_response.dart';
import '../services/user_service.dart';
import 'login_page.dart';

class WorkerDetail extends StatefulWidget {
  final Worker worker;
  String adress;
  WorkerDetail(this.worker,this.adress);

  @override
  State<WorkerDetail> createState() => _WorkerDetailState(worker,adress);
}

class _WorkerDetailState extends State<WorkerDetail> {

  Worker worker;
  String adress;
  List<dynamic> _serviceList = [];
  bool loading = true;


  _WorkerDetailState(this.worker,this.adress);

  

 /* void getWorkerOnPage(int? workerId) async {
  ApiResponse response = await getWorker(workerId);
  if(response.error == null) {
    setState(() {
      worker = response.data as Worker;
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
}*/

@override
  void initState() {
    /*getWorkerOnPage(workerId);*/
    //_getServiceList(worker.workerId);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network("https://media.istockphoto.com/photos/hairdresser-tools-on-black-background-with-copy-space-in-center-picture-id1020439322?k=20&m=1020439322&s=612x612&w=0&h=G36h0LByMKWWmbNsJbswkMpj-de4SAXIzZZhggQ44kU=",
                  fit: BoxFit.fill,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.purple.withOpacity(0.1),
                    ),
                ],
              ),
            ),
            Positioned(
                top: 50,
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 140,),
                         Text("Hakkında", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        const SizedBox(height: 20,),
                        Text("${worker.bio}", maxLines: 10, textAlign: TextAlign.justify ,style: TextStyle(letterSpacing: 1.7),),
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.email, size: 30,color: primaryColor,)),
                            SizedBox(width: 20,),
                           IconButton(onPressed: (){

                            }, icon: Icon(Icons.phone, size: 30,color: primaryColor,)),
                          ],
                        ),

                        SizedBox(height: 30,),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(style: ElevatedButton.styleFrom(
                primary: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>ServicePage(worker.workerId, adress)));
                          }, child: Text("Randevu Al")),
                        )

                      /*  Container(
                          color: Colors.white,
                          child: _serviceList.length == 0? Text("Uygun Servis Yok")
                           : ListView.builder(                
                           itemCount: _serviceList.length,
                           itemBuilder: (BuildContext context, index) {
                           Worker worker = _serviceList[index];
                           return Text("data");
                           }),
                        )*/
                        
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 90,
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 6 + 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("$localURL${worker.photo}"),
                          fit: BoxFit.cover
                          
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 20,),

                    Padding(
                      padding: const EdgeInsets.only(top:40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${worker.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          ),
                          const SizedBox(width: 10,),

                          Text("${worker.ilce}")
                        ],
                      ),
                    )
                  ],
                ),
                ),
              ),

              
              

          ]),
        ),
      )
    );
  }
}