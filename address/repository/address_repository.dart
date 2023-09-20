import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/firebase_providers.dart';

import '../../../core/type_defs.dart';
import '../../../model/address_model.dart';

final addressRepositoryProvider = Provider(
    (ref) => AddressRepository(firestore: ref.read(firestoreProvider)));

class AddressRepository {
  final FirebaseFirestore _firestore;
  AddressRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  //update Address
  FutureEither<bool> addUpdateAddress({
    required String uid,
    required List<AddressModel> addressList,
  }) async {
    try {
      await _users
          .doc(uid)
          .update({'address': addressList.map((e) => e.toMap()).toList()});
      return right(true);
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //delete an Address
  FutureVoid deleteAnAddress({
    required String uid,
    required String addressId,
    required List<AddressModel> addressList,
  }) async {
    try {
      addressList.removeWhere((address) => address.id == addressId);
      await _users
          .doc(uid)
          .update({'address': addressList.map((e) => e.toMap()).toList()});
      return right(null);
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //update Local addressList
  FutureEither<List<AddressModel>> updateLocalAddressList(String uid) async {
    try {
      List<AddressModel> addressList = [];
      await _users.doc(uid).get().then((value) {
        final address = value['address'];
        if ((address as List).isNotEmpty) {
          addressList = AddressModel.fromMapList(
              List<Map<String, dynamic>>.from(address));
        }
      });
      return right(addressList);
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
