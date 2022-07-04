class UserModel {
  String? uuid;
  final String name;
  final HomeData homeData;
  final String userType;

  UserModel({
    this.uuid,
    required this.name,
    required this.homeData,
    required this.userType,
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
