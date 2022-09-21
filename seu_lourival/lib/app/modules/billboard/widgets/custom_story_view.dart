import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/data/models/user_model.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/modules/billboard/controller.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';
import 'package:seu_lourival/routes/routes.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../../global_widgets/dialog/confirm_dialog.dart';

class CustomStoryView extends StatelessWidget {
  final List<StoryModel> stories;
  final bool repeat;
  final String title;
  final VoidCallback? onComplete;
  final BillboardController _controller;
  final isAdmin = Get.find<UserService>().user?.type == UserType.ADMIN;

  String currentStoryId = "";

  StoryController get _storyController => _controller.storyController;

  List<StoryItem> storyItemList() {
    return stories
        .map(
          (story) => StoryItemHelper.fromStoryModel(
            story,
            controller: _storyController,
            isAdmin: !isAdmin,
          ),
        )
        .toList();
  }

  CustomStoryView(
    this._controller, {
    Key? key,
    this.stories = const <StoryModel>[],
    this.repeat = false,
    this.onComplete,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: title,
      hasDrawer: false,
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                _storyController.pause();
                DSConfirmDialog(
                        context: context,
                        onConfirmAction: () {
                          _controller.deleteStory(currentStoryId);
                          _controller.reloadStories();

                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(Routes.billboard),
                          );
                        },
                        title: '🗑 Excluir manifesto',
                        descriptionLine1: 'Essa ação não poderá ser desfeita.',
                        descriptionLine2:
                            'Você tem certeza que deseja excluir esse manifesto?')
                    .show();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        )
      ],
      body: StoryView(
        storyItems: storyItemList(),
        controller: _storyController,
        repeat: repeat,
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.of(context).pop();
          }
        },
        onComplete: () {
          Navigator.of(context).pop();
          if (onComplete != null) {
            onComplete!();
          }
        },
        onStoryShow: (story) {
          final id = story.view.key
              .toString()
              .replaceAll("[<'", "")
              .replaceAll("'>]", "");
          currentStoryId = id;
        },
      ),
    );
  }
}

extension StoryItemHelper on StoryItem {
  static StoryItem fromStoryModel(
    StoryModel model, {
    required StoryController controller,
    bool isAdmin = false,
  }) {
    if (model.url == null) {
      return StoryItem.text(
        key: ValueKey(model.id),
        title: model.caption ?? "",
        backgroundColor: Colors.green,
        duration: isAdmin ? 100.seconds : 5.seconds,
      );
    } else {
      return StoryItem.pageImage(
        key: ValueKey(model.id),
        url: model.url ?? "",
        controller: controller,
        caption: model.caption,
        duration: isAdmin ? 100.seconds : 5.seconds,
      );
    }
  }
}
