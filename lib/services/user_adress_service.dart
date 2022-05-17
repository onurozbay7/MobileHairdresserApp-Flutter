import 'dart:convert';

import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:mobilehairdresser_app/models/user_adress.dart';
import 'package:mobilehairdresser_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';




// CREATE USER ADRESS

Future<ApiResponse> createUserAdress (String adresName, String il,String adres) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
     final response = await http.post(
      Uri.parse(createAdressUrl),
      headers: {'Accept' : 'application/json', 'Authorization' : 'Bearer $token'},
      body: {
        'adresName': adresName,
        'il': il,
        'adres': adres,
      }

    );
    
    
    switch(response.statusCode){
      case 200:
        
        apiResponse.data = UserAdress.fromJson(jsonDecode(response.body));
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
    
  }

  return apiResponse;
}


// GET USER ADRESS

Future<ApiResponse> getUserAdress () async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
     final response = await http.get(
      Uri.parse(getAdressUrl),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      

    );
    
    
    switch(response.statusCode){
      case 200:
        
        apiResponse.data = (jsonDecode(response.body)['userAdress'].map((p) => UserAdress.fromJson(p)).toList());
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
    
  }

  return apiResponse;
}

// DELETE USER ADRESS

Future<ApiResponse> deleteUserAdress (int adresId) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
     final response = await http.post(
      Uri.parse('$deleteAdressUrl/$adresId'),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      

    );
    
    
    switch(response.statusCode){
      case 200:
        
        apiResponse.error = jsonDecode(response.body)['message'];;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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
    
  }

  return apiResponse;
}