import 'package:ecommerce_app/core/utils.dart';
import 'package:ecommerce_app/features/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/features/favorite/controller/favorite_controller.dart';

import 'package:ecommerce_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../repository/auth_repository.dart';
import '../screens/email_verification_screen.dart';

import '../screens/sign_in_screen.dart';

//user provider
final userProvider = StateProvider<UserModel?>((ref) => null);

//authControllerProvider
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider(
  ((ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.authStateChange;
  }),
);

//get User data
final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  //check UserStateChanges
  Stream<User?> get authStateChange => _authRepository.authStateChange;

//google sign-in
  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle(context);
    state = false;
    user.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (userModel) async {
      if (userModel != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => EmailVerificationScreen(
                uid: userModel.id,
                email: userModel.email,
              ),
            ),
            (route) => false);
      }
      // if (userModel != null) {
      //   if (userModel.email.isEmpty) {
      //     print("**NotAnEmail");
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => EmailVerificationScreen(
      //           uid: userModel.id,
      //         ),
      //       ),
      //     );
      //   } else {
      //     print("**EmailIsIncluded");
      //     await _ref.read(userProvider.notifier).update((state) => userModel);
      //     await _ref
      //         .read(favoriteProvider.notifier)
      //         .update((state) => userModel.favorite);
      //     await _ref
      //         .read(cartProvider.notifier)
      //         .update((state) => userModel.cart);
      //     Navigator.pushNamedAndRemoveUntil(
      //         context, BottomBar.routeName, (route) => false);
      //   }
      // }
    });
  }

//facebook sign-in
  void signInWithFacebook(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithFacebook(context);
    state = false;
    user.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (userModel) async {
      if (userModel != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => EmailVerificationScreen(
                uid: userModel.id,
                email: userModel.email,
              ),
            ),
            (route) => false);
      }
      // if (userModel != null) {
      //   if (userModel.email.isNotEmpty) {
      //     print("**EmailIsIncluded");
      //     await _ref.read(userProvider.notifier).update((state) => userModel);
      //     await _ref
      //         .read(favoriteProvider.notifier)
      //         .update((state) => userModel.favorite);
      //     await _ref
      //         .read(cartProvider.notifier)
      //         .update((state) => userModel.cart);
      //     Navigator.pushNamedAndRemoveUntil(
      //         context, BottomBar.routeName, (route) => false);
      //   } else {
      //     print("**NotAnEmail");
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => EmailVerificationScreen(
      //           uid: userModel.id,
      //         ),
      //       ),
      //     );
      //   }
      // } else {
      //   await _ref.read(userProvider.notifier).update((state) => null);
      // }
    });
  }

//** NEED TO DEVELOP **//
  //LinkedIn sign-in
  Future signInWithLinkedin({
    required UserSucceededAction linkedInUser,
    required BuildContext context,
  }) async {
    state = true;
    final user = await _authRepository.signInWithLinkedIn(
        context: context, linkedInUser: linkedInUser);
    state = false;
    user.fold((l) => showSnackBar(context: context, text: l.message),
        (userModel) async {
      if (userModel != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => EmailVerificationScreen(
                uid: userModel.id,
                email: userModel.email,
              ),
            ),
            (route) => false);
      }
      // if (userModel != null && userModel.email.isEmpty) {
      //   print("**NotAnEmail");
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => EmailVerificationScreen(
      //         uid: userModel.id,
      //       ),
      //     ),
      //   );
      // } else {
      //   print("**EmailIsIncluded");
      //   await _ref.read(userProvider.notifier).update((state) => userModel);
      //   await _ref
      //       .read(favoriteProvider.notifier)
      //       .update((state) => userModel != null ? userModel.favorite : []);
      //   await _ref
      //       .read(cartProvider.notifier)
      //       .update((state) => userModel != null ? userModel.cart : []);
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, BottomBar.routeName, (route) => false);
      // }
    });
  }

//email sign-up
  void signUpWithEmail(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    state = true;
    final user = await _authRepository.signUpWithEmail(
        context: context, email: email, password: password, name: name);
    state = false;
    user.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (isOk) {
      if (isOk) {
        showSnackBar(
            context: context, text: "Register completed! Now you can Sign-IN");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SignInScreen(
              emailControllerText: email,
            ),
          ),
        );
      }
    });
  }

//email sign-in
  void signInWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final user = await _authRepository.signInWithEmail(
      email: email,
      password: password,
    );
    state = false;
    user.fold(
      (l) {
        showSnackBar(context: context, text: l.message);
      },
      (userModel) async {
        if (userModel != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => EmailVerificationScreen(
                  uid: userModel.id,
                  email: userModel.email,
                ),
              ),
              (route) => false);
        }

        // if (userModel != null && userModel.email.isEmpty) {
        //   print("**NotAnEmail");
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (_) => EmailVerificationScreen(
        //         uid: userModel.id,
        //       ),
        //     ),
        //   );
        // } else {
        //   print("**EmailIsIncluded");
        //   await _ref.read(userProvider.notifier).update((state) => userModel);
        //   await _ref
        //       .read(favoriteProvider.notifier)
        //       .update((state) => userModel != null ? userModel.favorite : []);
        //   await _ref
        //       .read(cartProvider.notifier)
        //       .update((state) => userModel != null ? userModel.cart : []);
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, BottomBar.routeName, (route) => false);
        // }}
      },
    );
  }

  //Sign Out
  Future<void> signOut({
    required BuildContext context,
  }) async {
    state = true;
    final user = await _authRepository.signOut();
    state = false;
    user.fold(
      (l) {
        showSnackBar(context: context, text: l.message);
      },
      (r) async {
        await _ref.read(favoriteProvider.notifier).update((state) => []);
        await _ref.read(cartProvider.notifier).update((state) => []);
        await _ref.read(userProvider.notifier).update((state) => null);
        showSnackBar(context: context, text: "LogOut Successful!");
        await Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) {
          return SignInScreen();
        }), (route) => false);
      },
    );
  }

  //save email only
  Future<bool> saveEmail({
    required BuildContext context,
    required String email,
    required String uid,
    // bool? isLoginScreen,
  }) async {
    bool returnValue = false;
    state = true;
    final res = await _authRepository.saveEmail(email: email, uid: uid);
    state = false;
    res.fold(
      (l) {
        showSnackBar(context: context, text: l.message);
        print(l.message);
      },
      (userModel) async {
        print("Email Save Is Successfull");
        await _ref.read(userProvider.notifier).update((state) => userModel);
        print("Email Save 1");
        await _ref
            .read(favoriteProvider.notifier)
            .update((state) => userModel != null ? userModel.favorite : []);
        print("Email Save 2");
        await _ref
            .read(cartProvider.notifier)
            .update((state) => userModel != null ? userModel.cart : []);
        print("Email Save 3");
        // if (isLoginScreen == null) {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, BottomBar.routeName, (route) => false);
        // }
        returnValue = true;
      },
    );
    await Future.delayed(
      Duration(seconds: 0),
    );
    return returnValue;
  }

  //check user is verified
  Future<bool> checkUserIsVerified({
    required BuildContext context,
    bool? isTimerOn,
  }) async {
    bool returnValue = false;
    isTimerOn != null ? null : state = true;

    final res = await _authRepository.checkUserIsVerified();
    isTimerOn != null ? null : state = false;
    res.fold(
      (l) {
        showSnackBar(context: context, text: l.message);
      },
      (isVerified) async {
        returnValue = isVerified;
      },
    );
    return returnValue;
  }

  //user verify by email
  Future<bool> userEmailVerify({
    required BuildContext context,
    required String email,
    required String uid,
  }) async {
    bool returnValue = false;
    state = true;
    final isEmailSave = await saveEmail(
      context: context,
      email: email,
      uid: uid,
    );

    print('isEmailSave $isEmailSave');
    if (isEmailSave) {
      final res = await _authRepository.userEmailVerify();
      state = false;
      res.fold(
        (l) {
          showSnackBar(context: context, text: l.message);
        },
        (isVerified) async {
          returnValue = isVerified;
        },
      );
    } else {
      state = false;
    }

    return returnValue;
  }

//get current user data
  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid: uid);
  }

  //linkedIN error handling
  void linkedInErrorHandling({required String error}) {
    print("Linkedin Error: error");
  }
}
