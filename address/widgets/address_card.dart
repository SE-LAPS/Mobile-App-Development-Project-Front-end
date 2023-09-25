// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/address/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/palette.dart';
import '../../../model/address_model.dart';
import '../../../core/common/widgets/add_address_dialog_box.dart';

class AddressCard extends ConsumerStatefulWidget {
  final AddressModel address;
  final int index;

  const AddressCard({
    Key? key,
    required this.address,
    required this.index,
  }) : super(key: key);

  @override
  ConsumerState<AddressCard> createState() => _AddressCardConsumerState();
}

class _AddressCardConsumerState extends ConsumerState<AddressCard> {
  void onPressedDelete() {
    ref
        .read(addressControllerProvider.notifier)
        .deleteAnAddress(context: context, addressId: widget.address.id);
  }

  //show addEdit Dialog
  void addEditAddressDialog({AddressModel? address, int? index}) {
    showDialog(
      context: context,
      builder: (_) => AddEditDialog(address: address, index: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: blackColorShade2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.address.fullName),
                    Text(widget.address.mobileNumber),
                    Text(widget.address.province),
                    Text(widget.address.cityTown),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: widget.index == 0
                            ? SizedBox(
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      backgroundColor: primaryColor),
                                  onPressed: () {},
                                  child: const Text(
                                    "Default",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          onPressed: onPressedDelete,
                          icon: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.grey, width: 1.7),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: grayColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      addEditAddressDialog(
                          address: widget.address, index: widget.index);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
