import 'package:flutter/material.dart';

import 'package:seu_lourival/app/pages/users_manager/pre-register/form/page.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class PreRegisterListPage extends StatelessWidget {
  PreRegisterListPage({Key? key}) : super(key: key);

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
        // ListView(
        //   // scrollDirection: Axis.vertical,
        // ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: DSColors.primary,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => PreRegisterFormPage()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
