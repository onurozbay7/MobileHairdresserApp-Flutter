import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/screens/worker_detail_page.dart';
import '../models/api_response.dart';
import '../models/worker.dart';
import '../services/user_service.dart';
import '../services/worker_service.dart';
import 'login_page.dart';

class WorkerPage extends StatefulWidget {
  String sehir;
  String adress;
  WorkerPage(this.sehir,this.adress);

  @override
  State<WorkerPage> createState() => _WorkerPageState(sehir,adress);
}

class _WorkerPageState extends State<WorkerPage> {

  bool loading = true;

  String adress;
  List<dynamic> _workerProfiles = [];

  String sehir;

  _WorkerPageState(this.sehir,this.adress);


  void _getWorkers(String? il) async {
  ApiResponse response = await getWorkerProfiles(il);
  if(response.error == null) {
    setState(() {
      _workerProfiles = response.data as List<dynamic>;
      loading = loading? !loading : loading;
      print(_workerProfiles.length);
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
    _getWorkers(sehir);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return loading? const Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Kuaförler"),
      ),
      body: Container(
        color: Colors.white,
        child: _workerProfiles.length == 0? Text("Uygun Kuaför Yok")
         : ListView.builder(                
           itemCount: _workerProfiles.length,
           itemBuilder: (BuildContext context, index) {
           Worker worker = _workerProfiles[index];
           return getWorkerCard(worker.name, worker.photo, worker.ilce,worker, getImage(index));
           }),
                            
      )
      );
  }
  
  String getImage(index) {
    
      if(index%4 == 3){
        return "https://img.freepik.com/free-photo/combs-scissors-copy-space_23-2148352839.jpg?w=1380";
      }
      else if(index%4 == 1) {
        return "https://img.freepik.com/free-photo/makeup-cosmetic-beauty-products-pink-background_23-2148113421.jpg";
      }

      else if(index%4 == 2){
        return localURL +"images/bg/bgg.jpg"; 
      }

      else{
       return "https://img.freepik.com/free-photo/stylist-supplies-with-hair_23-2148352848.jpg?t=st=1654379514~exp=1654380114~hmac=a786dacd37ebe4cd6aa032d8ad44fff9050891c97fa63612f646ed26f02b24c2&w=1060";
      }
    
  }



  Widget getWorkerCard(name, photo, ilce,worker,img){
    String photoUrl = localURL + photo;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:(context)=>WorkerDetail(worker, adress)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical:20, horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6 -20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
         // image: NetworkImage("https://img.freepik.com/free-photo/makeup-cosmetic-beauty-products-pink-background_23-2148113421.jpg"),
         image: NetworkImage(img),
          fit: BoxFit.cover
        
        )
        
        ),
        
        child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 6 -20,
                    child: Container(
                      width: MediaQuery.of(context).size.width /3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        image: DecorationImage(
                          image: NetworkImage(photoUrl),
                          fit: BoxFit.cover
                          
                        )
                      ),
                      
                    ),
                  ),
                
            

               Padding(
                padding: const EdgeInsets.only(top: 40, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,)),

                    const SizedBox(height: 5,),

                    Text(ilce)
                  ],
                ),
              ),
            
          ],
        ),

        
        
      ),
    );
  }
}