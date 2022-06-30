import 'dart:convert';

import 'package:mobilehairdresser_app/models/appointment.dart';
import 'package:mobilehairdresser_app/models/appointmentClear.dart';
import 'package:mobilehairdresser_app/services/user_service.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import '../models/api_response.dart';



// CREATE APOOINTMENT

Future<ApiResponse> createAppointment (String workerId, String date, String workingHourId, String adress, String serviceId, String text) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
     final response = await http.post(
      Uri.parse(createAppointmentURL),
      headers: {'Accept' : 'application/json', 'Authorization' : 'Bearer $token'},
      body: {
        'workerId': workerId,
        'date': date,
        'workingHourId': workingHourId,
        'adress': adress,
        'serviceId': serviceId,
        'text': text
      }

    );
    
    
    switch(response.statusCode){
      case 200:
        
        apiResponse.data = Appointment.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch(e) {
    apiResponse.error = e.toString();
    print(e.toString());
    
  }

  return apiResponse;
}


// GET APPOINTMENTS

Future<ApiResponse> getAppointments () async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
     final response = await http.get(
      Uri.parse(getAppointmentsURl),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      

    );
    
    
    switch(response.statusCode){
      case 200:
        
        apiResponse.data = (jsonDecode(response.body)['appointments'].map((p) => AppointmentClear.fromJson(p)).toList());
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch(e) {
    apiResponse.error = e.toString();
    print(e.toString());
  }

  return apiResponse;
}