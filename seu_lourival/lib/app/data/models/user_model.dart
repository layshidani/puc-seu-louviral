class UserModel {
  String? uuid;
  final String name;
  final HomeData homeData;
  final String type;
  final String cpf;
  final String phone;
  final String email;

  UserModel({
    this.uuid,
    required this.name,
    required this.homeData,
    required this.type,
    required this.cpf,
    required this.phone,
    required this.email,
  });
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
