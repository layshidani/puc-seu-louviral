import 'package:flutter/material.dart';
import 'package:seu_lourival/_debug/DS_catalog/text.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';

class ThemesCatalogPage extends StatelessWidget {
  const ThemesCatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
     title: 'Catálogo de temas',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Textos'),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TextCatalog()))
              },
            ),
            ElevatedButton(
              child: const Text('Botões'),
              onPressed: () => {},
            ),
            ElevatedButton(
              child: const Text('Campos'),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
