import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:story_view/story_view.dart';
import 'repository.dart';

class BillboardController extends GetxController {
  final BillboardRepository _repository;
  final storyController = StoryController();
  final storyCategories = <BillBoardModel>[].obs;
  final isLoading = false.obs;
  BillboardController(this._repository);

  @override
  void onInit() async {
    super.onInit();
    await _getStories();
  }

  Future<void> _getStories() async {
    isLoading.value = true;
    storyCategories.value = await _repository.getBillboardStories();
    isLoading.value = false;
  }
}

class BillBoardModel {
  final String category;
  final List<StoryModel> stories;

  BillBoardModel({required this.category, required this.stories});
}

class StoryModel {
  final String? caption;
  final String? url;

  StoryModel({
    this.caption,
    this.url,
  });
}
