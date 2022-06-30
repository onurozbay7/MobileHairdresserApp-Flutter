class WorkingHours{
  int? id;
  String? workerId;
  String? hours;
  bool? isActive;

  WorkingHours({
    this.id,
    this.workerId,
    this.hours,
    this.isActive
  });


  factory WorkingHours.fromJson(Map<String, dynamic> json){
    return WorkingHours(
      id: json['id'],
      workerId: json['workerId'],
      hours: json['hours'],
      isActive: json['isActive']
    );

  }
}