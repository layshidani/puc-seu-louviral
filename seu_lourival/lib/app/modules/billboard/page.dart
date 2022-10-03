import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/user_model.dart';
import 'package:seu_lourival/app/data/providers/billboard-category.provider.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/modules/billboard/widgets/custom_story_view.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/routes/routes.dart';
import 'controller.dart';

class BillboardPage extends StatelessWidget {
  BillboardPage({Key? key}) : super(key: key);

  final _controller = Get.find<BillboardController>();

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      hasDrawer: true,
      title: "Quadro de Avisos",
      floatingActionButton: Get.find<UserService>().user?.type == UserType.ADMIN
          ? FloatingActionButton(
              onPressed: () {
                Get.put(BillboardCategoryProvider());
                Get.toNamed(Routes.newBillboard);
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _controller.storyCategories.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "Ops, nenhum comunicado cadastrado",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      _controller.reloadStories();
                    },
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final model = _controller.storyCategories[index];
                        final url = model.stories.first.url;
                        final caption = model.stories.first.caption;
                        return Card(
                          elevation: 5,
                          child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              leading: url != null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(url),
                                    )
                                  : const Icon(Icons.camera_alt_outlined),
                              trailing: CircleAvatar(
                                backgroundColor: DSColors.tertiary,
                                radius: 12,
                                child: DSText.sm(
                                  model.stories.length.toString(),
                                ),
                              ),
                              title: Text(model.category),
                              subtitle: caption != null
                                  ? Text(
                                      caption,
                                      maxLines: 3,
                                    )
                                  : null,
                              onTap: () {
                                Get.to(CustomStoryView(
                                  _controller,
                                  stories: model.stories,
                                  title: model.category,
                                ));
                              }),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      padding: const EdgeInsets.all(8),
                      itemCount: _controller.storyCategories.length,
                    ),
                  ),
      ),
    );
  }
}
