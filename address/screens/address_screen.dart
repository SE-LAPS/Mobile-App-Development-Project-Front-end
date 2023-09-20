import 'package:ecommerce_app/features/address/controller/address_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/palette.dart';
import '../../../model/address_model.dart';
import '../../../core/common/widgets/add_address_dialog_box.dart';
import '../widgets/address_card.dart';

class AddressScreen extends ConsumerStatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenConsumerState();
}

class _AddressScreenConsumerState extends ConsumerState<AddressScreen> {
  //address
  List<AddressModel> _address = [];

  void navigateToBack() {
    Navigator.pop(context);
  }

  //show addEdit Dialog
  void addEditAddressDialog(AddressModel? address, int? index) {
    showDialog(
      context: context,
      builder: (_) => AddEditDialog(address: address, index: index),
    );
  }

  //updateLocalAddressList
  void updateLocalAddressList() {
    ref
        .read(addressControllerProvider.notifier)
        .updateLocalAddressList(context: context);
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      updateLocalAddressList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _res = ref.watch(addressProvider);
    if (_res.isNotEmpty) {
      _address = _res;
    }
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            centerTitle: true,
            title: const Text("User Details",
                style: TextStyle(color: blackColorShade1, fontSize: 25)),
            leading: IconButton(
                onPressed: navigateToBack,
                icon: const Icon(
                  Icons.arrow_back,
                  color: blackColorShade1,
                  size: 35,
                )),
            elevation: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _address.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(bottom: 10),
                  itemCount: _address.length,
                  itemBuilder: (BuildContext context, index) {
                    final address = _address[index];
                    return AddressCard(
                      address: address,
                      index: index,
                    );
                  },
                )
              : const SizedBox(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addEditAddressDialog(null, null),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
