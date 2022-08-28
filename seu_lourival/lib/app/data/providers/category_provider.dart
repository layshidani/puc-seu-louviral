import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoryProvider {
  final _firestore = FirebaseFirestore.instance;
  final _categoryCollection = "categories";

  List<String> _categories = [];

  Future<List<String>> getCategories() async {
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
