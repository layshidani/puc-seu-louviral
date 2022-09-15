import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/billboard/controller.dart';
import 'package:story_view/story_view.dart';

class BillboardRepository {
//  todo: implement BillboardRepository methods;

  Future<List<BillBoardModel>> getBillboardStories() async {
    final stories = <BillBoardModel>[
      BillBoardModel(category: "Financeiro", stories: [
        StoryModel(
          caption:
              "Lembrando que teremos um aumento no valor da taxa de condomínio a partir de 10/10/2022. Lembrando que teremos um aumento no valor da taxa de condomínio a partir de 10/10/2022. Lembrando que teremos um aumento no valor da taxa de condomínio a partir de 10/10/2022. Lembrando que teremos um aumento no valor da taxa de condomínio a partir de 10/10/2022",
        ),
      ]),
      BillBoardModel(category: "Manutenção", stories: [
        StoryModel(
            caption:
                "Nosso elevador entrará em manutenção na noite de hoje (15/10)"),
        StoryModel(
          caption:
              "Interfone do bloco D está fora de serviço. Já estamos solicitando reparos",
        ),
      ]),
      BillBoardModel(category: "Aniversários", stories: [
        StoryModel(
          caption:
              "Bryan, morador do 405 - Bloco C está comemorando mais um ano de vida",
          url:
              "https://cf.shopee.com.br/file/38a45adbe0c39333138ff6f0b4f143b2_tn",
        ),
        StoryModel(
          caption:
              "Lays, moradora do 102 - Bloco C está comemorando mais um ano de vida",
          url:
              "https://play-lh.googleusercontent.com/IQ085_7QBCcNe4HKklLxqNmDC2CpHik38fL0GCn_X00Mdm1C2m4JYuMbKn9PuTAdIxU",
        ),
      ]),
    ];
    await Future.delayed(2.seconds);
    return stories;
  }
}
