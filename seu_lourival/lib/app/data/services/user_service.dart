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

  static List<Map<String, dynamic>> _prepareData(
      QuerySnapshot<Map<String, dynamic>> data) {
    return data.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}
