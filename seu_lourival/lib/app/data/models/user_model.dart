class UserModel {
  String? uuid;
  final String name;
  final String email;
  final String phone;
  final String type;
  final DateTime createdAt;
  final HomeData homeData;

  UserModel({
    this.uuid,
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
    required this.createdAt,
    required this.homeData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json?['name'],
      cpf: json?['cpf'],
      email: json?['email'],
      phone: json?['phone'],
      type: json?['type'],
      homeData: HomeData.fromJson(json?['homeData']),
      createdAt: json?['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'cpf': this.cpf,
      'email': this.email,
      'phone': this.phone,
      'type': this.type,
      'createdAt': this.createdAt,
      'homeData': this.homeData,
    };
  });

  @override
  String toString() {
    return "{uuid: $uuid,"
        "name: $name,"
        "email: $email,"
        "phoneNumber: $phoneNumber,"
        "homeData: { "
        "apartmentNumber: ${homeData.apartmentNumber},"
        "tower: ${homeData.tower},"
        "number: ${homeData.number},"
        "}, "
        "userType: $userType"
        "}";
  }
}

class HomeData {
  final String number;
  final String tower;

  HomeData({required this.number, required this.tower});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      number: json['homeData']['number'],
      tower: json['homeData']['tower'],
    );
  }
}

class UserContactInfo {
  final String email;
  final String phoneNumber;
  }
}
