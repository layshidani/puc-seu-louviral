import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/modules/onboarding/strings.dart';
import 'controller.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final _controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: [
          PageModel(
            color: const Color(0xFF0097A7),
            imageAssetPath: 'assets/onboarding/zelador.png',
            title: OnboardingStrings.helloPage.title,
            body: OnboardingStrings.helloPage.body,
            doAnimateImage: true,
          ),
          PageModel(
            color: const Color(0xFF536DFE),
            imageAssetPath: 'assets/onboarding/people.png',
            title: OnboardingStrings.communityPage.title,
            body: OnboardingStrings.communityPage.body,
            doAnimateImage: true,
          ),
          PageModel(
            color: const Color(0xFF9B90BC),
            imageAssetPath: 'assets/onboarding/noticias.png',
            title: OnboardingStrings.newsPage.title,
            body: OnboardingStrings.newsPage.body,
            doAnimateImage: true,
          ),
          PageModel(
            color: const Color(0xFF0097A7),
            imageAssetPath: 'assets/onboarding/manutencao.png',
            title: OnboardingStrings.maintenancePage.title,
            body: OnboardingStrings.maintenancePage.body,
            doAnimateImage: true,
          ),
          PageModel(
            color: const Color(0xFF536DFE),
            imageAssetPath: 'assets/onboarding/questao.png',
            title: OnboardingStrings.helpPage.title,
            body: OnboardingStrings.helpPage.body,
            doAnimateImage: true,
          ),
          PageModel(
            color: const Color(0xFF9B90BC),
            imageAssetPath: 'assets/onboarding/superhero.png',
            title: OnboardingStrings.heroPage.title,
            body: OnboardingStrings.heroPage.body,
            doAnimateImage: true,
          ),
        ],
        finishCallback: () {
          _controller.didFinishOnboarding();
        },
        skipText: OnboardingStrings.skipText,
        nextText: OnboardingStrings.nextText,
        finishText: OnboardingStrings.finishText,
      ),
    );
  }
}
