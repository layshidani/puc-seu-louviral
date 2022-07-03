import 'package:flutter/material.dart';

import 'package:seu_lourival/app/pages/users_manager/pre-register/form/page.dart';
import 'package:seu_lourival/core/values/colors.dart';

class PreRegisterListPage extends StatelessWidget {
  const PreRegisterListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: DSColors.primary,
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => PreRegisterForm()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
