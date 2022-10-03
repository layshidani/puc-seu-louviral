import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:seu_lourival/app/data/providers/billboard-category.provider.dart';

class NewBillboardRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final categoryCollection = "categories-billboard";
  final billboardCollection = "billboards";
  final BillboardCategoryProvider _categoryProvider;

  NewBillboardRepository(this._categoryProvider);

  Future<List<String>> getCategories() async {
    return await _categoryProvider.getBillboardCategories();
  }

  Future<String> addBillboard(model) async {
    final result =
        await _firestore.collection(billboardCollection).add(model.toJson());
    return result.id;
  }

  Future<String> uploadImage({required File file, required String ref}) async {
    final result = await _storage.ref(ref).putFile(file);
    return await result.ref.getDownloadURL();
  }
}
