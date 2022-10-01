import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seu_lourival/app/data/providers/category_provider.dart';

class MaintenanceRepository {
  final _categoryProvider = CategoryProvider();
  final String maintenanceContactDatabase = "maintenance";
  final _firestore = FirebaseFirestore.instance;

  Future<List<String>> getCategories() async {
    return await _categoryProvider.getCategories();
  }

  Future<String> saveMaintenanceContact(Map<String, dynamic> json) async {
    try {
      final result =
          await _firestore.collection(maintenanceContactDatabase).add(json);
      return result.id;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteMaintenanceContact(String id) async {
    try {
      _firestore.collection(maintenanceContactDatabase).doc(id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getMaintenanceContacts() async {
    try {
      final result = await _firestore
          .collection(maintenanceContactDatabase)
          .orderBy("name")
          .get();
      final json = result.docs.map((document) {
        final data = document.data();
        data["id"] = document.id;
        return data;
      });
      return json.toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
