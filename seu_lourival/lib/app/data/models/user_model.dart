class UserModel {
  String? uuid;
  final String name;
  final String cpf;
  final String email;
  final String phone;
  final String type;
  final String apartmentNumber;
  final String tower;
  final DateTime createdAt;
  // final HomeData homeData;

  UserModel({
    this.uuid,
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.type,
    required this.apartmentNumber,
    required this.tower,
    required this.createdAt,
    // required this.homeData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      cpf: json['cpf'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      apartmentNumber: json['apartmentNumber'],
      tower: json['tower'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'cpf': this.cpf,
      'email': this.email,
      'phone': this.phone,
      'type': this.type,
      'apartmentNumber': this.apartmentNumber,
      'tower': this.tower,
      'createdAt': this.createdAt,
    };
  }
}

class HomeData {
  final int apartmentNumber;
  final String tower;

  HomeData({required this.apartmentNumber, required this.tower});
}

class UserContactInfo {
  final String email;
  final String phoneNumber;

  UserContactInfo({required this.email, required this.phoneNumber});
}
