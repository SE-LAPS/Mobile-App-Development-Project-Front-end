import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/auth_controller.dart';
import '../repository/account_repository.dart';

//authControllerProvider
final accountControllerProvider =
    StateNotifierProvider<AccountController, bool>(
  (ref) => AccountController(
    accountRepository: ref.watch(accountRepositoryProvider),
    ref: ref,
  ),
);

class AccountController extends StateNotifier<bool> {
  final AccountRepository _accountRepository;
  final Ref _ref;
  AccountController(
      {required AccountRepository accountRepository, required Ref ref})
      : _accountRepository = accountRepository,
        _ref = ref,
        super(false);

  //get category list
  void logOut(BuildContext context) {
    state = true;
    final res =
        _ref.read(authControllerProvider.notifier).signOut(context: context);
    state = false;
  }
}
