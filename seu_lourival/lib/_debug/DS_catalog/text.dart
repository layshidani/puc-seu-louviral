import 'package:flutter/material.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class TextCatalog extends StatelessWidget {
  const TextCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: 'Catálogo de temas',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DSTitle.sm(
            'Título (sm)',
          ),
          DSTitle.base(
            'Título (base)',
          ),
          DSTitle.lg(
            'Título (lg)',
          ),
          const Divider(),
          DSText.sm(
            'Texto (sm)',
          ),
          DSText.base(
            'Texto (base)',
          ),
          DSText.lg(
            'Texto (lg)',
          ),
          const Divider(),
          ElevatedButton(
            child: DSText.base('Exemplo'),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TextCalatalogExample()))
            },
          ),
        ],
      ),
    );
  }
}

class TextCalatalogExample extends StatelessWidget {
  const TextCalatalogExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: 'Catálogo de temas',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DSTitle.sm(
                'Título (sm)',
              ),
              DSText.sm(
                    'Texto (sm): Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              ),
              const Divider(),
              DSTitle.base(
                'Título (base)',
              ),
              DSText.base(
                    'Texto (base): Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              ),
              const Divider(),
              DSTitle.lg(
                'Título (lg)',
              ),
              DSText.lg(
                    'Texto (lg): Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
