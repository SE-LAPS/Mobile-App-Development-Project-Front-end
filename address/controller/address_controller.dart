import 'package:ecommerce_app/core/utils.dart';
import 'package:ecommerce_app/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/common/controller/common_get_date_and_time_controller.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/address_repository.dart';

//address provider
final addressProvider = StateProvider<List<AddressModel>>((ref) => []);

//Address ControllerProvider
final addressControllerProvider =
    StateNotifierProvider<AddressController, bool>(
  (ref) => AddressController(
    addressRepository: ref.watch(addressRepositoryProvider),
    ref: ref,
  ),
);

class AddressController extends StateNotifier<bool> {
  final AddressRepository _addressRepository;
  final Ref _ref;
  AddressController(
      {required AddressRepository addressRepository, required Ref ref})
      : _addressRepository = addressRepository,
        _ref = ref,
        super(false);

  //update  Address
  Future<void> addUpdateAddress({
    required BuildContext context,
    required String? id,
    required DateTime? dateTime,
    required String fullName,
    required String zipCode,
    required String address,
    required String mobileNumber,
    required String province,
    required String cityTown,
    required bool isDefaultAddress,
  }) async {
    state = true;

    final userAddress = _ref.read(userProvider)!.address;
    final uid = _ref.read(userProvider)!.id;

    //find old one and update
    //If it doesn't have Id add Id
    if (id != null) {
      userAddress.removeWhere((e) => e.id == id);
    } else {
      // ignore: use_build_context_synchronously
      final date = await _ref
          .read(commonGetDateAndTimeControllerProvider.notifier)
          .getDateAndTime(context);
      const uuid = Uuid();
      id = uuid.v1();
      dateTime = date != null ? DateTime.parse(date) : DateTime.now();
    }

//addressModel
    final addressModel = AddressModel(
      zipCode: zipCode,
      address: address,
      cityTown: cityTown,
      fullName: fullName,
      id: id,
      mobileNumber: mobileNumber,
      province: province,
      dateTime: dateTime,
    );

//check is Default address and make it default
    if (isDefaultAddress) {
      userAddress.insert(0, addressModel);
    } else {
      userAddress.add(addressModel);
    }

    final res = await _ref.read(addressRepositoryProvider).addUpdateAddress(
          addressList: userAddress,
          uid: uid,
        );
    state = false;
    res.fold(
        (l) => showSnackBar(
            context: context,
            text: " Something went wrong! ${l.message}"), (isSaved) {
      if (isSaved) {
        showSnackBar(context: context, text: "Address is Saved");
        updateLocalAddressList(context: context);
        Navigator.pop(context);
      }
    });
  }

  //update address List
  void updateLocalAddressList({required BuildContext context}) async {
    state = true;

    final res = await _ref
        .read(addressRepositoryProvider)
        .updateLocalAddressList(_ref.read(userProvider)!.id);
    state = false;
    res.fold(
        (l) => showSnackBar(
            context: context,
            text: " Something went wrong! ${l.message}"), (addressList) {
      _ref.read(addressProvider.notifier).update((state) => addressList);
    });
  }

  //Delete an address from the list
  void deleteAnAddress({
    required BuildContext context,
    required String addressId,
  }) async {
    state = true;
    final userAddress = _ref.read(addressProvider);
    final uid = _ref.read(userProvider)!.id;

    final res = await _ref.read(addressRepositoryProvider).deleteAnAddress(
        addressList: userAddress, addressId: addressId, uid: uid);
    state = false;
    res.fold(
        (l) => showSnackBar(
            context: context,
            text: " Something went wrong! ${l.message}"), (r) {
      showSnackBar(context: context, text: "Address is deleted");
      updateLocalAddressList(context: context);
    });
  }
}
