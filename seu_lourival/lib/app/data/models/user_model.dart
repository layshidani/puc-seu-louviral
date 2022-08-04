class UserModel {
  String? uuid;
  final String name;
  final String email;
  final String phoneNumber;
  final HomeData homeData;
  final String userType;

  UserModel({
    this.uuid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.homeData,
    required this.userType,
  });

  @override
  String toString() {
    return "{uuid: $uuid, "
        "name: $name, "
        " email: $email, "
        " phoneNumber: $phoneNumber, "
        "homeData: { "
        "apartmentNumber: ${homeData.apartmentNumber}, "
        " tower: ${homeData.tower}, "
        "}, "
        "userType: $userType"
        "}";
  }

  factory UserModel.fromJson(Map<String, dynamic>? json,
      {required String uuid}) {
    return UserModel(
      name: json?["name"],
      homeData: HomeData.fromJson(json?["homeData"]),
      email: json?["email"],
      phoneNumber: json?["phoneNumber"],
      userType: json?["userType"],
      uuid: uuid,
    );
  }
}

class HomeData {
  final int apartmentNumber;
  final String tower;

  HomeData({required this.apartmentNumber, required this.tower});

  factory HomeData.fromJson(Map<String, dynamic>? json) {
    return HomeData(
      apartmentNumber: json?["apartmentNumber"],
      tower: json?["tower"],
    );
  }
}
