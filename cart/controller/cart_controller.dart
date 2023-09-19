import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';
import '../../../model/product.dart';
import '../../../model/user.dart';

import '../../auth/controller/auth_controller.dart';
import '../repository/cart_repository.dart';

//user provider
final cartProvider = StateProvider<List<ProductModel>>((ref) => []);

//CartControllerProvider
final cartControllerProvider = StateNotifierProvider<CartController, bool>(
  (ref) => CartController(
    cartRepository: ref.watch(cartRepositoryProvider),
    ref: ref,
  ),
);

//get Cart data future
final cartFutureProvider =
    FutureProvider.family<List<ProductModel>?, BuildContext>((ref, context) {
  final cartController = ref.watch(cartControllerProvider.notifier);
  return cartController.getCartData(context);
});

class CartController extends StateNotifier<bool> {
  final CartRepository _cartRepository;
  final Ref _ref;
  CartController({required CartRepository cartRepository, required Ref ref})
      : _cartRepository = cartRepository,
        _ref = ref,
        super(false);

  //add to cart
  Future<bool> addToCart({
    required ProductModel product,
    required BuildContext context,
  }) async {
    bool returnValue = false;
    state = true;
    final res =
        await _cartRepository.addToCart(_ref.read(userProvider)!.id, product);
    state = false;
    res.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (isOver) {
      returnValue = isOver;
      if (isOver) {
        updateCartList(context: context);
      }
    });
    return returnValue;
  }

  //get cartProduct list
  Future<List<ProductModel>?> getCartData(BuildContext context) async {
    List<ProductModel>? returnValue;

    final res = await _cartRepository.getCartData(_ref.read(userProvider)!.id);

    res.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (cartList) {
      returnValue = cartList;
      _ref.read(cartProvider.notifier).update((state) => cartList ?? []);
    });

    return returnValue;
  }

  //get User data

  Future<UserModel?> getUserData({
    required BuildContext context,
  }) async {
    UserModel? returnValue;
    state = true;
    final res =
        await _cartRepository.getUserData(uid: _ref.read(userProvider)!.id);
    state = false;
    res.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (user) {
      returnValue = user;
    });
    return returnValue;
  }

  //remove a product from the cart product list

  Future<bool> removeAProductFromTheCartList({
    required String productID,
    required BuildContext context,
  }) async {
    bool returnValue = false;
    state = true;
    final res = await _cartRepository.removeAProductFromTheCart(
      uid: _ref.read(userProvider)!.id,
      productId: productID,
    );
    state = false;
    res.fold((l) {
      showSnackBar(context: context, text: l.message);
    }, (isOK) {
      returnValue = isOK;
      updateCartList(context: context);
    });
    return returnValue;
  }

//Update cart List
  void updateCartList({required BuildContext context}) {
    _ref.read(cartControllerProvider.notifier).getCartData(context).then(
        (cartProductList) => _ref
            .read(cartProvider.notifier)
            .update((state) => cartProductList ?? []));
  }

//check email is verified
}
