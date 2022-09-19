import 'package:cloud_firestore/cloud_firestore.dart';

class BillboardCategoryProvider {
  final _firestore = FirebaseFirestore.instance;
  final _categoryCollection = "categories-billboard";

  List<String> _categories = [];

  Future<List<String>> getBillboardCategories() async {
    if (_categories.isNotEmpty) {
      return _categories;
    }

    final result =
        await _firestore.collection(_categoryCollection).orderBy("title").get();
    final categories = result.docs.map((doc) {
      return doc["title"] as String;
    }).toList();
    _categories = categories;
    return _categories;
  }
}
