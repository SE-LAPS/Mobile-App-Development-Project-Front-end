import 'package:ecommerce_app/core/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/custom_button.dart';

import '../../../core/common/custom_text_field.dart';
import '../../../core/common/widgets/loader.dart';

import '../controller/auth_controller.dart';

import 'dart:ui' as ui;

class GetEmailScree extends ConsumerStatefulWidget {
  final String uid;
  const GetEmailScree({
    required this.uid,
    super.key,
  });

  @override
  ConsumerState<GetEmailScree> createState() => _GetEmailScreenConsumerState();
}

class _GetEmailScreenConsumerState extends ConsumerState<GetEmailScree> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  //next button press
  void nextButtonPress() {
    if (_emailController.text.isNotEmpty) {
      saveEmail(_emailController.text);
    } else {
      print("Email is empty");
    }
  }

  //call to saveEmail function in the authcontroller
  void saveEmail(String email) {
    ref
        .read(authControllerProvider.notifier)
        .saveEmail(context: context, email: email, uid: widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading = ref.watch(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                    child: Row(
                      children: const [
                        Icon(Icons.email_outlined),
                        SizedBox(width: 10),
                        Text("Add Your Email")
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 50,
                    child: CustomTextField(
                        controller: _emailController, hintText: "Email"),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  //sign up button
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                      text: "Next",
                      onPressed: () {
                        nextButtonPress();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            _isLoading
                ? Positioned.fill(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: 3.0,
                          sigmaY: 3.0,
                        ),
                        child: const Loader(),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
