import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/firebase_constants.dart';

import '../../../../core/providers/firebase_providers.dart';
import '../../../core/failure.dart';

import '../../../core/type_defs.dart';
import '../../../model/product.dart';
import '../../../model/user.dart';

final cartRepositoryProvider = Provider(
  (ref) => CartRepository(
    firestore: ref.read(firestoreProvider),
  ),
);

class CartRepository {
  final FirebaseFirestore _firestore;

  CartRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  //add Product To cart Product List
  FutureEither<bool> addToCart(String uid, ProductModel product) async {
    try {
      List<ProductModel> cartProductList = [];
      UserModel? userModel;

      final res = await getUserData(uid: uid);
      res.fold((l) => throw (l.message), (r) {
        cartProductList = r.cart;
        userModel = r;
      });

      if (userModel != null) {
        if (cartProductList.isNotEmpty) {
          for (var element in cartProductList) {
            if (element.id == product.id) {
              throw ("Already have in cart!");
            }
          }
        }

        cartProductList.add(product);

        final UserModel user = userModel!.copyWith(cart: cartProductList);

        //generate Search keywords
        final List<String> searchKeyword = [];
        final splittedMultipleWords = user.name.trim().split(" ");
        for (var element in splittedMultipleWords) {
          final String wordToLowercase = element.toLowerCase();
          for (var i = 1; i < wordToLowercase.length + 1; i++) {
            searchKeyword.add(wordToLowercase.substring(0, i));
          }

          final finalUser =
              UserModel.toMap(userModel: user, searchKeyword: searchKeyword);

          await _users.doc(uid).set(finalUser);
          return right(true);
        }
      }
      return right(false);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //get cart Product List
  FutureEither<List<ProductModel>?> getCartData(String uid) async {
    try {
      List<ProductModel>? cartProductList;
      final user = await getUserData(uid: uid);
      user.fold((l) => throw (l.message), (r) => cartProductList = r.cart);
      if (cartProductList == null ||
          cartProductList!.isEmpty ||
          cartProductList!.contains(null)) {
        cartProductList = null;
      }
      return right(cartProductList);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //get user data
  FutureEither<UserModel> getUserData({required String uid}) async {
    try {
      final getUser = await _users.doc(uid).get();
      final user = UserModel.fromMap(getUser.data() as Map<String, dynamic>);
      return right(user);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //remove an product from a cart
  FutureEither<bool> removeAProductFromTheCart(
      {required String uid, required String productId}) async {
    try {
      bool returnValue = false;

      List<ProductModel?>? cartProductList = [];
      UserModel? userModel;

      final res = await getUserData(uid: uid);
      res.fold((l) => throw (l.message), (r) {
        cartProductList = r.cart;
        userModel = r;
      });

      if (userModel != null) {
        for (var i = 0; i < cartProductList!.length; i++) {
          if (cartProductList![i]!.id == productId) {
            cartProductList!.removeAt(i);
          }
        }
        cartProductList!.removeWhere((element) => element == null);
        _users.doc(uid).update({
          'cart': cartProductList!.map((product) {
            //Generate search Keywords
            final List<String> searchKeyword = [];
            final splittedMultipleWords = product!.name.trim().split(" ");
            for (var element in splittedMultipleWords) {
              final String wordToLowercase = element.toLowerCase();
              for (var i = 1; i < wordToLowercase.length + 1; i++) {
                searchKeyword.add(wordToLowercase.substring(0, i));
              }
            }
            return ProductModel.toMap(
                productModel: product, searchKeyword: searchKeyword);
          }).toList()
        });

        returnValue = true;
      }
      return right(returnValue);
    } on FirebaseException catch (e) {
      return left(
        Failure(
          e.message.toString(),
        ),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
