import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/custom_button.dart';

import '../../../core/common/custom_text_field.dart';
import '../../../core/common/widgets/loader.dart';
import '../../../core/constants/assets_path.dart';
import '../../../core/enums/enums.dart';
import '../../../core/palette.dart';

import '../controller/auth_controller.dart';
import '../widgets/social_button.dart';
import 'sign_up_screen.dart';
import 'dart:ui' as ui;

class SignInScreen extends ConsumerStatefulWidget {
  final String emailControllerText;
  const SignInScreen({super.key, this.emailControllerText = ""});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenConsumerState();
}

class _SignInScreenConsumerState extends ConsumerState<SignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    if (widget.emailControllerText.isNotEmpty) {
      _emailController.text = widget.emailControllerText;
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

//navigation
  void navigateToSignUpScreen({
    required BuildContext context,
    required String emailControllerText,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignUpScreen(emailControllerText: emailControllerText),
      ),
    );
  }

  //call to sign-in function in the controller
  void signIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      ref.read(authControllerProvider.notifier).signInWithEmail(
          context: context,
          email: _emailController.text,
          password: _passwordController.text);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //Logo
                  Image.asset(logoPath, height: 260),
                  const SizedBox(height: 15),
                  //Email
                  Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.email_outlined),
                          SizedBox(width: 10),
                          Text("Your Email")
                        ],
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(
                          controller: _emailController, hintText: "Email")
                    ],
                  ),
                  const SizedBox(height: 15),
                  //Password
                  Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.lock_outline),
                          SizedBox(width: 10),
                          Text("Password")
                        ],
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(
                          controller: _passwordController, hintText: "password")
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Foget Password?",
                            style: TextStyle(color: textColor),
                          ))
                    ],
                  ),

                  //sign up button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    // primary: Colors.blue, // Set the button's background color
                    //  onPrimary: Colors.white, // Set the text color
                    elevation: 5, // Set the elevation (shadow)
                    minimumSize: Size(420, 45), // Set the minimum button size
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set the button's border radius
                    ),
                  ),
                  onPressed: () {
                  signIn();
                },
                  child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 18),
                  ),
                ),
                  const SizedBox(height: 15),
                  // or continue with F G L
                  Row(
                    children: const [
                      // Divider(color: Text_color),
                      Text("  Or Continue With  "),
                      // Divider(color: Text_color),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Icon Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      SocialButton(
                          ctx: context,
                          iconPath: facebookPath,
                          label: '',
                          socialButtonType: SocialButtonType.facebook),
                      SizedBox(width: 10),
                      SocialButton(
                          ctx: context,
                          iconPath: googlePath,
                          label: '',
                          socialButtonType: SocialButtonType.google),
                      // SizedBox(width: 10),
                      // SocialButton(
                      //     ctx: context,
                      //     iconPath: linkedInPath,
                      //     label: '',
                      //     socialButtonType: SocialButtonType.linkedIn),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Text + text button (Already a user ? sign in)
                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Are You a new user?"),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          navigateToSignUpScreen(
                              context: context,
                              emailControllerText: _emailController.text);
                        },
                        child: const Text("Sign up"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5)
                ],
              ),
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
    );
  }
}
