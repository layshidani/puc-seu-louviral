import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:seu_lourival/app/modules/report/new_report/controller.dart';

class NewReportRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final categoryCollection = "categories";
  final reportCollection = "reports";

  Future<List<String>> getCategories() async {
    final result =
        await _firestore.collection(categoryCollection).orderBy("title").get();
    final categories = result.docs.map((doc) {
      return doc["title"] as String;
    }).toList();
    return categories;
  }

  Future<void> addReport(Report model) async {
    await _firestore.collection(reportCollection).add(model.toJson());
  }

  Future<String> uploadImage({required File file, required String ref}) async {
    final result = await _storage.ref(ref).putFile(file);
    return await result.ref.getDownloadURL();
  }
}

// class Category {
//   final String title;
//   final String icon;
//   Category({required this.title, required this.icon});
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       title: json["title"],
//       icon: json["icon"],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "title": this.title,
//       "icon": this.icon,
//     };
//   }
// }

class Report {
  final String title;
  final String description;
  final String photoURL;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final Author author;
  final bool isPrivate;
  final String category;

  Report({
    required this.title,
    required this.description,
    required this.photoURL,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.author,
    required this.isPrivate,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "photoURL": photoURL,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "status": status,
      "isPrivate": isPrivate,
      "author": author.name,
      "phone": author.phone,
      "id": author.uuid,
      "category": category,
    };
  }
}

class Author {
  final String uuid;
  final String name;
  final String phone;

  Author({
    required this.uuid,
    required this.name,
    required this.phone,
  });
}
