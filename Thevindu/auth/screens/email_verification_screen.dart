import 'dart:async';
import 'dart:ui' as ui;

import 'package:ecommerce_app/core/common/custom_button.dart';
import 'package:ecommerce_app/core/palette.dart';
import 'package:ecommerce_app/features/auth/controller/auth_controller.dart';
import 'package:ecommerce_app/features/home/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/custom_text_field.dart';
import '../../../core/common/widgets/loader.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/email-verification';
  final String uid;
  final String? email;
  // final double total;
  // final List<CartSelectedProductModel> selectedProductList;

  const EmailVerificationScreen({
    this.email,
    required this.uid,
    super.key,
    // required this.total,
    //  required this.selectedProductList,
  });

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenConsumerState();
}

class _EmailVerificationScreenConsumerState
    extends ConsumerState<EmailVerificationScreen> {
  bool _isUserVerified = false;
  bool _isSendButtonOn = true;
  bool _resendText = false;
  bool _isVerificationSend = false;

//for text field
  final _emailFormKey = GlobalKey<FormState>();
  late final TextEditingController _emailVerificationController;

//for countdown stream
  int countDown = 0;

//for check emailIsVerify after send request
  Timer? timer;

  void init() async {
    _isUserVerified = await checkUserIsVerified();
    print("Is user verified : $_isUserVerified");
    if (!_isUserVerified && widget.email != null && widget.email!.isNotEmpty) {
      _emailVerificationController.text = widget.email!;
    }
  }

  @override
  void initState() {
    _emailVerificationController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      init();
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailVerificationController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void sendButtonPress() async {
    final bool isOk = _emailFormKey.currentState!.validate();
    if (isOk) {
      _isVerificationSend = await emailVerify();

      _isSendButtonOn = false;

      _resendText = true;
      CountDowntimer();
      print("OK");
      timer = Timer.periodic(Duration(seconds: 3), (_) {
        checkUserVerificationContinuously();
        //print("Timer is Working!!");
      });
      setState(() {});
    }
  }

  //check userVerification continuously
  Future<void> checkUserVerificationContinuously() async {
    final isVerified = await ref
        .read(authControllerProvider.notifier)
        .checkUserIsVerified(context: context, isTimerOn: true);
    print("hellopp");
    if (isVerified) {
      timer?.cancel();
      setState(() {
        _isUserVerified = true;
      });
    }
  }

  //check onetime userVerification
  Future<bool> checkUserIsVerified() async {
    return await ref
        .read(authControllerProvider.notifier)
        .checkUserIsVerified(context: context);
  }

  Future<bool> emailVerify() async {
    return await ref.read(authControllerProvider.notifier).userEmailVerify(
          context: context,
          email: _emailVerificationController.text,
          uid: widget.uid,
        );
  }

  Stream<int> CountDowntimer() async* {
    for (var i = 20; i >= 0; i--) {
      yield i;
      await Future.delayed(
        Duration(seconds: 1),
      );

      if (i == 0) {
        setState(() {
          _isSendButtonOn = true;
        });
      }
    }
  }

  //backButtonPress
  void backButtonPress() async {
    _isUserVerified = false;
    _isSendButtonOn = true;
    _resendText = false;
    _isVerificationSend = false;
    timer?.cancel();
    ref.read(authControllerProvider.notifier).signOut(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool _isLoading = ref.watch(authControllerProvider);
    return _isUserVerified
        ? BottomBar()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    backButtonPress();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                backgroundColor: primaryColor,
                title: Text('Email Verification'),
              ),
              body: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: 300, maxHeight: 150),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Type your email'),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Form(
                                  key: _emailFormKey,
                                  child: CustomTextField(
                                    controller: _emailVerificationController,
                                    hintText: 'Email',
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _isVerificationSend
                                    ? Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: primaryColorShade1,
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'Verification link is sent. Please check your Email',
                                          style: TextStyle(
                                            color: textColor2,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          _isSendButtonOn
                              ? SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: CustomButton(
                                    text: _resendText || _isVerificationSend
                                        ? "Resend"
                                        : "Send",
                                    onPressed: sendButtonPress,
                                  ),
                                )
                              : SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: StreamBuilder(
                                    stream: CountDowntimer(),
                                    builder: (context, snapshot) =>
                                        CustomButton(
                                      backgroundColor: grayColor,
                                      text: "Wait to resend ${snapshot.data}",
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _isLoading
                      ? SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                              sigmaX: 3.0,
                              sigmaY: 3.0,
                            ),
                            child: const Loader(),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
  }
}
