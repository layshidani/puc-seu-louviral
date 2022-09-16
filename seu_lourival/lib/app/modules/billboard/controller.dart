import 'package:get/get.dart';
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
  String? id;
  String? caption;
  String? url;
  String? category;
  DateTime? createdAt;

  StoryModel({
    this.id,
    this.caption,
    this.category,
    this.createdAt,
    this.url,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      caption: json['caption'],
      url: json['url'],
      category: json['category'],
      createdAt: json['createdAt'],
    );
  }

  // @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caption': caption,
      'category': category,
      'url': url,
    };
  }
}

enum BillboardCategory {
  GENERAL,
  FIXED,
  FINANCIAL,
  KEEP,
  OTHER,
}

extension BillboardCategoryExtension on BillboardCategory {
  String get description {
    switch (this) {
      case BillboardCategory.GENERAL:
        return '📝 Geral';
      case BillboardCategory.FIXED:
        return '📍 Fixo';
      case BillboardCategory.FINANCIAL:
        return '💵 Financeiro';
      case BillboardCategory.KEEP:
        return '🛠 Manutenção';
      default:
        return '📢 Outros';
    }
  }
}

class BillboardCategoryHelper {
  static BillboardCategory fromString(String category) {
    try {
      final cat = BillboardCategory.values.firstWhere((billboardCategory) {
        return category.contains(billboardCategory.description);
      });
      return cat;
    } catch (e) {
      return BillboardCategory.OTHER;
    }
  }
}
