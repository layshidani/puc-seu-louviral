import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';

class ReportService {
  static Future<List<ReportModel>> getReports() async {
    try {
      final result = _prepareData(await FirebaseFirestore.instance
          .collection('reports')
          // .orderBy("createdAt", descending: false)
          .orderBy("createdAt", descending: true)
          .get());

      if (result.isEmpty) {
        return [];
      }

      return result.map((json) {
        print("--> JSOOOOOOON: ${json}");
        return ReportModel.fromJson(json);
      }).toList();
    } catch (e) {
      print('🚩 $e');
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
