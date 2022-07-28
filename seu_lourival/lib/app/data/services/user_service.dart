import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seu_lourival/app/data/models/user_model.dart';

class UserService {
  UserModel? user;

  bool get isLoggedIn => user != null;

  Future<void> loadCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final id = currentUser.uid;
      final result =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      user = UserModel.fromJson(result.data(), uuid: id);
    }
  }
}
