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

  factory MaintenanceContactModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceContactModel(
      category: json["category"],
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
