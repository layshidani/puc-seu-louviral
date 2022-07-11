import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/users_manager/registered_list/controller.dart';
import 'package:seu_lourival/core/utils/datetime_helper.dart';
import 'package:seu_lourival/core/values/user_types.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class RegisteredList extends StatelessWidget {
  RegisteredList({Key? key}) : super(key: key);
  var controller = Get.put(RegisteredListController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        side: const BorderSide(
                          color: Colors.white70,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      onPressed: () => controller.clearFilter(),
                      child: const Icon(
                        Icons.filter_alt_off_outlined,
                        color: Color.fromARGB(255, 66, 65, 65),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          side: const BorderSide(
                            color: Colors.white70,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        onPressed: () => controller.getUsersList(),
                        child: const Icon(
                          Icons.refresh_rounded,
                          color: Color.fromARGB(255, 66, 65, 65),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  DSText.sm('Tipo:  '),
                  Obx(
                    () => DropdownButton(
                      items: userTypes.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      value: controller.selectedFilter,
                      onChanged: (item) {
                        controller.onFilterUsers(item as String);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Obx(
          () =>
              //controller.isLoading ? CustomLoading() :
              Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.getUsersList();
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: controller.usersListFiltered.length,
                itemBuilder: (context, index) {
                  final user = controller.usersListFiltered[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DSTitle.xsm('${user['name']}'),
                            IconButton(
                              onPressed: () {
                                controller.onConfirmDelete(context, user);
                              },
                              icon: const Icon(Icons.delete_outline_rounded),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform(
                              transform: Matrix4.identity()..scale(0.8),
                              child: Chip(
                                label: DSText.xsm('${user['type']}'),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor:
                                    Color.fromARGB(46, 0, 155, 198),
                              ),
                            ),
                            Text(
                              'Data de inclusão: ${(user['createdAt'] != null) ? DateTimeHelper.fromTimeStamp(user['createdAt']) : '-'}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Divider(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
