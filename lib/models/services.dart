class Services {
  int? id;
  int? workerId;
  String? serviceName;
  String? price;

  Services ({
    this.id,
    this.workerId,
    this.serviceName,
    this.price
});

factory Services.fromJson(Map<String, dynamic> json){
    return Services(
      id: json['id'],
      workerId: json['workerId'],
      serviceName: json['serviceName'],
      price: json['price'],

    );


}

}