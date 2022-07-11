import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';

class UserService {
  static Future<List<Map<String, dynamic>>> getUsersList() async {
    try {
      final result = await FirebaseFirestore.instance.collection('users').get();

      return _prepareData(result);
    } catch (e) {
      return throw Exception('Ops. Ocorreu um erro ao recuperar os dados');
    }
  }

  static Future<List<Map<String, dynamic>>> getPreRegisteredUsersList() async {
    try {
      final result =
          await FirebaseFirestore.instance.collection('pre-registered').get();

      return _prepareData(result);
    } catch (e) {
      return throw Exception('Ops. Ocorreu um erro ao recuperar os dados');
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
      return throw Exception('Ops. Ocorreu um erro ao recuperar os dados');
    }
  }

  static List<Map<String, dynamic>> _prepareData(
      QuerySnapshot<Map<String, dynamic>> data) {
    return data.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}
