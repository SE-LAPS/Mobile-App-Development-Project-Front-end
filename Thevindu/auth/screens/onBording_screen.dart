import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../core/common/custom_button.dart';
import '../../../core/constants/assets_path.dart';
import '../../../core/palette.dart';
import '../../home/screens/home_screen.dart';

import 'sign_up_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  void routeToSignUpScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
              title: 'Welcome',
              body:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, ',
              image: Image.asset(obsM1)),
          PageViewModel(
              title: 'Quick annd fast Delivery',
              body:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, ',
              image: Image.asset(obsM2)),
          PageViewModel(
              title: 'Fresh Food and Vegitables',
              body:
                  'Screen 3 bodyLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem ',
              image: Image.asset(obsM3)),
        ],
        done: CustomButton(
            text: "Sign Up",
            onPressed: () {
              routeToSignUpScreen(context);
            }),
        onDone: () => routeToSignUpScreen(context),
        showSkipButton: true,
        skip: const Text(
          'Skip',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        onSkip: () => const HomeScreen(),
        next: const Icon(
          Icons.arrow_forward,
          color: primaryColor,
        ),
        dotsDecorator: const DotsDecorator(activeColor: primaryColor),
        onChange: (index) => print('Page $index selected'),
        // globalBackgroundColor: Theme.of(context).primaryColor,
        skipOrBackFlex: 0,
      ),
    );
  }
}
