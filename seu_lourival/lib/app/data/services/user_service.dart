import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seu_lourival/app/data/models/user_model.dart';

class UserService {
  UserModel? user;

  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  Future<bool> loadCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final id = currentUser.uid;
      final result =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      user = UserModel.fromJson(result.data(), uuid: id);
      return true;
    }
    return false;
  }

  static onSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
       return throw Exception('Ops, ocorreu um erro. Tente novamente');
    }
  }

  static onDeletePreRegistered({required String cpf}) async {
    try {
      await FirebaseFirestore.instance
          .collection('pre-registered')
          .where('cpf', isEqualTo: cpf)
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  FirebaseFirestore.instance
                      .collection('pre-registered')
                      .doc(element.id)
                      .delete();
                })
              });
    } catch (e) {
      return throw Exception('Ops. Ocorreu um erro ao recuperar os dados');
    }
  }

  static onDeleteUser({required String cpf}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('cpf', isEqualTo: cpf)
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(element.id)
                      .delete();
                })
              });
    } catch (e) {
      return throw Exception('Ops, ocorreu um erro. Tente novamente.');
    }
  }

  static List<Map<String, dynamic>> _prepareData(
      QuerySnapshot<Map<String, dynamic>> data) {
    return data.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}
