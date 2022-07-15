import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_list/controller.dart';
import 'package:seu_lourival/app/widgets/custom_loading.dart';
import 'package:seu_lourival/core/utils/datetime_helper.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/core/values/user_types.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';
import 'package:seu_lourival/routes/routes.dart';

class AddUsersList extends StatelessWidget {
  AddUsersList({Key? key}) : super(key: key);
  var controller = Get.put(AddUsersListController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                children: [
                  DSText.sm('Tipo:  '),
                  Obx(
                    () => DropdownButton(
                      items: types.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      value: controller.selectedFilter,
                      onChanged: (item) {
                        controller.onFilterPreRegisterUsers(item as String);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Obx(() => 
          //controller.isLoading ? CustomLoading() :
            Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.getPreRegisteredList();
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: controller.preRegisteredListFiltered.length,
                itemBuilder: (context, index) {
                  final user = controller.preRegisteredListFiltered[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DSTitle.xsm('${user['name']}'),
                            Chip(
                              label: DSText.xsm('${user['type']}'),
                            ),
                          ],
                        ),
                        Text(
                          'Data de inclusão: ${(user['createdAt'] != null) ? DateTimeHelper.fromTimeStamp(user['createdAt']) : '-'}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // FloatingActionButton(
              //   backgroundColor: DSColors.primary,
              //   child: const Icon(Icons.add),
              //   onPressed: () => Get.toNamed(Routes.addUsersForm),
              // ),
              ElevatedButton.icon(
                  onPressed: () => Get.toNamed(Routes.addUsersForm),
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar usuário'),
                  style: ElevatedButton.styleFrom(primary: DSColors.primary)),
            ],
          ),
        ),
      ],
    );
  }
}
