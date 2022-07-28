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

  factory UserModel.fromJson(Map<String, dynamic> json,
      {required String uuid}) {
    return UserModel(
      name: json["name"],
      homeData: json["homeData"],
      userType: json["userType"],
      uuid: uuid,
    );
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
