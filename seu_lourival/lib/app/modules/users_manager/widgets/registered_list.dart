import 'package:flutter/material.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class RegisteredList extends StatelessWidget {
  RegisteredList({Key? key}) : super(key: key);

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
   return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DSText.sm('Tipo:   '),
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
        ],
      ),
    );
  }
}
