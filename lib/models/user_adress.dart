class UserAdress {
  int? id;
  String? userId;
  String? adresName;
  String? il;
  String? adres;

  UserAdress({
    this.id,
    this.userId,
    this.adresName,
    this.il,
    this.adres
  });

  factory UserAdress.fromJson(Map<String, dynamic> json){
    return UserAdress(
      id: json['id'],
      userId: json['userId'],
      adresName: json['adresName'],
      il: json['il'],
      adres: json['adres'],

    );
  }
}