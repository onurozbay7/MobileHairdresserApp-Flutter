// STRINGS

import 'package:flutter/material.dart';

const localURL = "http://10.242.86.185/";

const baseUrl = "http://10.242.86.185/api";
const loginUrl = baseUrl + "/user/login";
const registerUrl = baseUrl + "/user/register";
const logoutUrl = baseUrl + "/user/logout";
const userUrl = baseUrl + "/user";
const createAdressUrl = baseUrl + "/user/createUserAdress";
const getAdressUrl = baseUrl + "/user/getUserAdress";
const deleteAdressUrl = baseUrl + "/user/deleteUserAdress";
const getWorkers = baseUrl + "/user/getWorkerProfile";
const pictures = "file:///C:/xampp/htdocs/mobilehairdresser/public/images/";
const getWorkerDetail = baseUrl + "/user/getWorker";
const getServiceUrl = baseUrl + "/user/getServiceList";
const getWorkingHoursUrl = baseUrl + "/user/working-hours";
const createAppointmentURL = baseUrl + "/user/createAppointment";
const getAppointmentsURl = baseUrl + "/user/getReelTimeAppointment";


// ERRORS
const serverError = "Server error";
const unauthorized = "Unauthorized";
const somethingWentWrong = "Something went wrong, try again!";


// INPUT DECORATİON
InputDecoration kInputDecoration(String label, Icon icon) {
  return InputDecoration(
    labelText: label,
    
    contentPadding: const EdgeInsets.all(10),
    border: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.pinkAccent)),
    prefixIcon: icon
  );
}

// TEXT BUTTON
TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(label, style: const TextStyle(color: Colors.white),), 
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10))
    ),
    onPressed: () => onPressed(),
  );
}

// LoginRegisterHint

Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(label, style: TextStyle(color: Colors.pinkAccent.shade400),),
        onTap: () => onTap(),
      )
    ],
  );
}

// PRIMARY COLOR
Color primaryColor = const Color.fromARGB(255, 88, 18, 100);

// White Text

primaryTextStyle() {
  return const TextStyle(
    color:  Color.fromARGB(255, 88, 18, 100),
    fontSize: 18
  );
}



// CITIES
final sehirler=["Adana", "Adıyaman", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "İçel (Mersin)", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"
];



