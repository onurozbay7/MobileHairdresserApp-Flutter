import 'package:flutter/material.dart';

class AppointmentClear {
  int? id;
  int? userId; 
  String? workerName;
  String? date;
  String? workingHour;
  String? adress;
  String? service;
  String? text;
  int? isAccept;

  AppointmentClear ({
    this.id,
    this.userId,
    this.workerName,
    this.date,
    this.workingHour,
    this.adress,
    this.service,
    this.text,
    this.isAccept
});

factory AppointmentClear.fromJson(Map<String, dynamic> json){
    return AppointmentClear(
      id: json['id'],
      userId: json['userId'],
      workerName: json['workerName'],
      date: json['date'],
      workingHour: json['workingHour'],
      adress: json['adress'],
      service: json['service'],
      text: json['text'],
      isAccept: json['isAccept'],
    );


}

}