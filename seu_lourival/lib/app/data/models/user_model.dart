class UserModel {
  String? uuid;
  final String name;
  final String email;
  final String phone;
  final String cpf;
  final HomeData? homeData;
  final String type;

  UserModel({
    this.uuid,
    this.homeData,
    required this.name,
    required this.email,
    required this.phone,
    required this.cpf,
    required this.type,
  });

  @override
  String toString() {
    return '{uuid: $uuid, '
        'name: $name, '
        ' email: $email, '
        ' phone: $phone, '
        ' phone: $cpf, '
        'homeData: { '
        'number: ${homeData?.number}, '
        ' tower: ${homeData?.tower}, '
        '}, '
        'type: $type'
        '}';
  }

  factory UserModel.fromJson(Map<String, dynamic>? json,
      {required String uuid}) {
    return UserModel(
      name: json?['name'],
      homeData: HomeData.fromJson(json?['homeData']),
      email: json?['email'],
      phone: json?['phone'],
      cpf: json?['cpf'],
      type: json?['type'],
      uuid: uuid,
    );
  }
}

class HomeData {
  final String number;
  final String tower;

  HomeData({required this.number, required this.tower});

  factory HomeData.fromJson(Map<String, dynamic>? json) {
    return HomeData(
      number: json?['number'],
      tower: json?['tower'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'tower': tower,
    };
  }
}
