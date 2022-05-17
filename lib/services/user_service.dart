

import 'dart:convert';

import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:mobilehairdresser_app/models/user_adress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';



// LOGİN
Future<ApiResponse> login (String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Accept' : 'application/json'},
      body: {'email': email, 'password': password}
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
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


// Register
Future<ApiResponse> register (String name, String phone,String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try{
     final response = await http.post(
      Uri.parse(registerUrl),
      headers: {'Accept' : 'application/json'},
      body: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }

    );
    
    
    switch(response.statusCode){
      case 200:
        
        apiResponse.data = User.fromJson(jsonDecode(response.body));
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


// User
Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
    final response = await http.get(
      Uri.parse(userUrl),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
        },
      
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
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
    apiResponse.error = serverError;
  }

  return apiResponse;
}

//GET TOKEN

Future<String> getToken() async{
SharedPreferences preferences = await SharedPreferences.getInstance();
return preferences.getString('token') ?? '';
}


//GET USER ID

Future<int> getUserId() async{
SharedPreferences preferences = await SharedPreferences.getInstance();
return preferences.getInt('userId') ?? 0;
}

//LOGOUT

Future<bool> logout() async{
SharedPreferences preferences = await SharedPreferences.getInstance();
return await preferences.remove('token');
}


