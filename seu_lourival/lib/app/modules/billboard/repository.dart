import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/billboard/controller.dart';
import 'package:story_view/story_view.dart';

class BillboardRepository {
  final _firestore = FirebaseFirestore.instance;
  final billboardCollection = "billboards";

  Future<List<BillBoardModel>> getBillboardStories() async {
    final categories = <String>[];
    final result = await _firestore
        .collection(billboardCollection)
        .orderBy("category")
        .get();
    final stories = result.docs.map((doc) {
      final data = doc.data();
      final model = StoryModel(
        caption: data["caption"],
        url: data["url"],
        category: data["category"],
        id: doc.id,
      );
      categories.addIf(
          !categories.contains(model.category), model.category ?? "");
      return model;
    }).toList();

    final models = <BillBoardModel>[];
    categories.forEach((cat) {
      final bb = BillBoardModel(category: cat);
      stories.forEach((sto) {
        if (sto.category == cat) {
          bb.addStory(sto);
        }
      });
      models.add(bb);
    });
    return models;
  }
}
