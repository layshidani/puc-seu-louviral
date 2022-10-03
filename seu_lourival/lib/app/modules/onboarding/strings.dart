abstract class OnboardingStrings {
  static const skipText = "Pular";
  static const nextText = "Próximo";
  static const finishText = "Continuar";
  static final helloPage = OnboardingPageStrings(
    title: "Olá,",
    body: "Somos o Seu Lourival!"
        "\nO app indispensável para melhorar a sua experiência aqui no condomínio!",
  );
  static final communityPage = OnboardingPageStrings(
    title: "Comunidade",
    body: "Você próximo de todos os vizinhos.\n"
        "Entre em contato com seus vizinhos sem sair de casa através do chat.",
  );
  static final newsPage = OnboardingPageStrings(
    title: "Notícias",
    body:
        "Não perca nenhum comunicado do condomínio com nosso quadro de avisos virtual",
  );
  static final maintenancePage = OnboardingPageStrings(
    title: "Manutenção",
    body: "Contatos de manutenção a um clique.\n"
        "Procure um profissional para auxiliá-lo e entre em contato!",
  );
  static final helpPage = OnboardingPageStrings(
    title: "E agora...?",
    body: "Preciso saber quando é a próxima reunião de condomínio!\n"
        "Estou com um vazamento na cozinha...\n"
        "O vizinho do 403 está com um som muito alto, como posso abrir uma reclamação?\n"
        "E agora, quem poderá me ajudar?",
  );
  static final heroPage = OnboardingPageStrings(
    title: "Seu Lourival",
    body:
        "O super-herói do condomínio esta aqui para ajudá-lo com tudo isso e muito mais!\n"
        "Termine já o seu primeiro acesso!",
  );
}

class OnboardingPageStrings {
  final String title;
  final String body;

  OnboardingPageStrings({
    required this.title,
    required this.body,
  });
}
