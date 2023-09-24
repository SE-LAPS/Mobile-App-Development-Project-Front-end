import 'package:ecommerce_app/features/auth/controller/auth_controller.dart';
import 'package:ecommerce_app/features/favorite/controller/favorite_controller.dart';
import 'package:ecommerce_app/features/home/widgets/bottom_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/error_text.dart';
import '../../../core/constants/assets_path.dart';

import '../../../model/user.dart';
import '../../cart/controller/cart_controller.dart';

import 'email_verification_screen.dart';
import 'sign_in_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenConsumerState();
}

class _SplashScreenConsumerState extends ConsumerState<SplashScreen> {
  UserModel? userModel;
  void getData(WidgetRef ref, User data) async {
    final res = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;

    if (res != null && res.email.isNotEmpty) {
      userModel = res;
    }

    if (userModel != null) {
      //update user
      await ref.read(userProvider.notifier).update((state) => userModel);
      // update Favorite Product List
      // ignore: use_build_context_synchronously
      // ref
      //     .read(favoriteControllerProvider.notifier)
      //     .updateFavoriteList(context: context);
      await ref
          .read(favoriteProvider.notifier)
          .update((state) => userModel!.favorite);

      // update cart list
      //ignore: use_build_context_synchronously
      // ref
      //     .read(cartControllerProvider.notifier)
      //     .updateCartList(context: context);
      await ref.read(cartProvider.notifier).update((state) => userModel!.cart);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (user) {
            if (user != null) {
              getData(ref, user);
              if (userModel != null && user.emailVerified) {
                //return EmailVerificationScreen(
                //  uid: userModel!.id,
                //);
                return const BottomBar();
              }
              if (userModel != null) {
                return EmailVerificationScreen(
                  uid: userModel!.id,
                );
              }
              if (userModel == null) {
                return SignInScreen();
              }
            }

            if (user == null) {
              return SignInScreen();
            }
            return loadingScreen();
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () {
            return loadingScreen();
          },
        );
  }

  Widget loadingScreen() {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              logoPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
