import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_list/controller.dart';
import 'package:seu_lourival/app/widgets/custom_loading.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class RegisteredList extends StatelessWidget {
  RegisteredList({Key? key}) : super(key: key);
  var controller = Get.put(AddUsersListController());

  List<String> userTypes = [
    'Todos',
    'Morador',
    'Porteiro',
    'Manutenção',
    'Zelador',
    'Financeiro',
    'Outros',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // SizedBox(
              //   height: 40,
              //   width: 40,
              //   child: TextButton(
              //     style: TextButton.styleFrom(
              //       backgroundColor: Colors.grey[300],
              //       side: const BorderSide(
              //         color: Colors.white70,
              //       ),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           side: const BorderSide(color: Colors.grey)),
              //     ),
              //     onPressed: () => controller.getRegisteredUsersList(),
              //     child: const Icon(
              //       Icons.refresh,
              //       color: Color.fromARGB(255, 66, 65, 65),
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DSText.sm('Tipo:  '),
                  DropdownButton<String>(
                    items: userTypes.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    // TODO change value
                    value: userTypes[0],
                  ),
                ],
              ),
            ],
          ),
        ),
        // Obx(() {
        //   return controller.isLoading
        //       ? CustomLoading()
        //       : Expanded(
        //           child: RefreshIndicator(
        //             onRefresh: () async {
        //               controller.getRegisteredUsersList();
        //             },
        //             child: ListView.builder(
        //               scrollDirection: Axis.vertical,
        //               shrinkWrap: true,
        //               itemCount: controller.registeredList.length,
        //               itemBuilder: (context, index) {
        //                 final user = controller.registeredList[index];
        //                 return Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           DSTitle.xsm('${user['name']}'),
        //                           Chip(
        //                             label: DSText.xsm('${user['type']}'),
        //                           ),
        //                         ],
        //                       ),
        //                       const Text(
        //                         'Data de inclusão: ',
        //                         style: TextStyle(
        //                           color: Colors.grey,
        //                           fontStyle: FontStyle.italic,
        //                         ),
        //                       ),
        //                       const Padding(
        //                         padding: EdgeInsets.only(top: 8.0),
        //                         child: Divider(),
        //                       ),
        //                     ],
        //                   ),
        //                 );
        //               },
        //             ),
        //           ),
        //         );
        // }),
      ],
    );
  }
}
