import 'package:flutter/material.dart';
import 'package:mobilehairdresser_app/services/user_adress_service.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../services/user_service.dart';

class CreateAdressPage extends StatefulWidget {
  CreateAdressPage({Key? key}) : super(key: key);

  @override
  State<CreateAdressPage> createState() => _CreateAdressPageState();
}
final GlobalKey<FormState> formkey = GlobalKey<FormState>();
class _CreateAdressPageState extends State<CreateAdressPage> {
  final TextEditingController 
  adresNameController = TextEditingController(),
  adresController = TextEditingController();

  String? value;
  bool loading = false;


  void _createAdress() async {
    ApiResponse response = await createUserAdress(adresNameController.text, value.toString(), adresController.text);
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
        title: Text("Adres Ekle"),
      ),

      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
      
            const SizedBox(height: 20,),
      
            TextFormField(
                controller: adresNameController,
                validator: (val) => val!.isEmpty ? 'Adres ismi boş bırakılamaz' : null,
                decoration: kInputDecoration("Adres İsmi",const Icon(Icons.people))
              ),
      
              const SizedBox(height: 20,),
      
              DropdownButtonFormField<String>(
                value: value,
                validator: (val) => val == null ? 'Şehir boş bırakılamaz' : null,
                decoration: kInputDecoration("Şehir Seç", Icon(Icons.location_city)),
                items: sehirler.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => this.value = value),
              ),
              
              const SizedBox(height: 20,),
      
              TextFormField(
                maxLines: 5,
                controller: adresController,
                validator: (val) => val!.isEmpty ? 'Adres bırakılamaz' : null,
                decoration: kInputDecoration("Adres",const Icon(Icons.location_on))
              ),
      
              const SizedBox(height: 10,),
      
      
              loading ?const Center(child: CircularProgressIndicator(),)
              :
              kTextButton("Adres Ekle", (){
              if(formkey.currentState!.validate()){
                setState(() {
                  loading = true;
                  _createAdress();
                  Navigator.pop(context);
                });
              }
                }),
      
          ],
        ),
      ),
    );

    
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value: item, child: Text(item),);
}