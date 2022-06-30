import 'package:flutter/material.dart';

class Appointment {
  int? id;
  int? userId; 
  int? workerId;
  DateTime? date;
  int? workingHourId;
  String? adress;
  int? service;
  String? text;
  bool? isAccept;

  Appointment ({
    this.id,
    this.userId,
    this.workerId,
    this.date,
    this.workingHourId,
    this.adress,
    this.service,
    this.text,
    this.isAccept
});

factory Appointment.fromJson(Map<String, dynamic> json){
    return Appointment(
      id: json['id'],
      userId: json['userId'],
      workerId: json['workerId'],
      date: json['date'],
      workingHourId: json['workingHourId'],
      adress: json['adress'],
      service: json['service'],
      text: json['text'],
      isAccept: json['isAccept'],
    );


}

}