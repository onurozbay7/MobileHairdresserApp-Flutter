import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:mobilehairdresser_app/models/services.dart';
import 'package:mobilehairdresser_app/models/user_adress.dart';
import 'package:mobilehairdresser_app/models/worker.dart';
import 'package:mobilehairdresser_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/working_hour.dart';


// GET WORKER PROFİLES

Future<ApiResponse> getWorkerProfiles (String? il) async {
  ApiResponse apiResponse = ApiResponse();
  try{
     String token = await getToken();
     final response = await http.get(
      Uri.parse('$getWorkers/$il'),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token',
      },
      

    );
    
    
    switch(response.statusCode){
      case 200:
        
        apiResponse.data = (jsonDecode(response.body)['workers'].map((p) => Worker.fromJson(p)).toList());
        apiResponse.data as List<dynamic>;
        debugPrint(response.body);
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

// GET WORKER

Future<ApiResponse> getWorker(int? id) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
    final response = await http.get(
      Uri.parse("$getWorkerDetail/$id"),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
        },
      
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = Worker.fromJson(jsonDecode(response.body));
        debugPrint(response.body);
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
    print(e.toString());
  }

  return apiResponse;
}

// GET SERVİCE LİST
Future<ApiResponse> getServiceList (int? id) async {
  ApiResponse apiResponse = ApiResponse();
  try{
     String token = await getToken();
     final response = await http.get(
      Uri.parse('$getServiceUrl/$id'),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token',
      },
      

    );
    
    
    switch(response.statusCode){
      case 200:
        
        apiResponse.data = (jsonDecode(response.body)['services'].map((p) => Services.fromJson(p)).toList());
        apiResponse.data as List<dynamic>;
        debugPrint(response.body);
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


// GET WORKING HOURS
Future<ApiResponse> getWorkingHours (int? id,DateTime dateTime) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
     final response = await http.get(
      Uri.parse('$getWorkingHoursUrl/$id/$dateTime'),
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      

    );
    
    
    switch(response.statusCode){
      case 200:
        apiResponse.data = (jsonDecode(response.body)['workingHours'].map((p) => WorkingHours.fromJson(p)).toList());
        apiResponse.data as List<dynamic>;
        print("object");
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
