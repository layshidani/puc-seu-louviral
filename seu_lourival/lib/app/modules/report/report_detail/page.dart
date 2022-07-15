import 'package:flutter/material.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class ReportDetailPage extends StatelessWidget {
  const ReportDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [DSTitle.lg('Detalhes do manifesto')],
    );
  }
}
