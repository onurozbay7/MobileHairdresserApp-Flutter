class Worker {
  int? id;
  int? workerId;
  String? name;
  String? email;
  String? phone;
  String? bio;
  String? photo;
  String? belge;
  String? il;
  String? ilce;
  int? isAccept;
  

  Worker({
    this.id,
    this.workerId,
    this.name,
    this.email,
    this.phone,
    this.bio,
    this.belge,
    this.photo,
    this.il,
    this.ilce,
    this.isAccept
    
    
  });

  factory Worker.fromJson(Map<String, dynamic> json){
    return Worker(
      id: json['id'],
      workerId: json['workerId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      bio: json['bio'],
      photo: json['photo'],
      belge: json['belge'],
      il: json['il'],
      ilce: json['ilce'],
      isAccept: json['isAccept'],

    );
  }
}