class MaintenanceContactModel {
  String? id;
  List<String> category;
  String name;
  String phone;

  MaintenanceContactModel({
    required this.category,
    required this.name,
    required this.phone,
    this.id,
  });

  factory MaintenanceContactModel.fromJson(
      {required Map<String, dynamic> json}) {
    return MaintenanceContactModel(
      /*
        Foi necessário utilizar esse .cast<Type>() para converter o json["category"]
        em List<String>, pois apenas utilizando 'as List<String>' estava quebrando
        ao tentar realizar o parse
      */
      category: json["category"].cast<String>(),
      name: json["name"],
      phone: json["phone"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "name": name,
      "phone": phone,
    };
  }
}
