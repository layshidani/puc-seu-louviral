import 'package:get/get.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/routes/routes.dart';

import '../models/report_model.dart';
import 'custom_search_delegate.dart';
import 'package:flutter/material.dart';

class ReportSearch extends CustomSearchDelegate {
  final List<ReportModel> reports;

  ReportSearch({required this.reports});

  @override
  Widget buildSuggestions(BuildContext context) {
    print("building suggestions");
    final suggestions = reports.where((report) {
      final input = query.toLowerCase();
      return report.title.toLowerCase().contains(input);
    }).toList();

    if (suggestions.isEmpty) {
      return Center(
        child: DSText.lg("Nenhum manigesto encontrado 🤨"),
      );
    }

    final length = suggestions.length > 5 ? 5 : suggestions.length;

    return ListView.separated(
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion.title),
          onTap: () {
            // dismiss na tela de pesquisa
            Get.back();

            // redireciona para tela de detalhes passando o report pesquisado
            Get.toNamed(
              Routes.reportDetail,
              arguments: suggestion,
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: length,
    );
  }
}
