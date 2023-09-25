import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../core/common/widgets/add_address_dialog_box.dart';
import '../../../core/constants/constants.dart';
import '../../../core/palette.dart';
import '../../../model/address_model.dart';

import '../../../model/cart_selected_product_model.dart';
import '../../address/controller/address_controller.dart';

import '../../home/widgets/bottom_bar.dart';
import '../widgets/customGridView.dart';

import 'package:http/http.dart' as http;

//visa card
// 4242 4242 4242 4242
//12/34
//567

class PaymentScreen extends ConsumerStatefulWidget {
  static const String routeName = "/paymentScreen";
  final double total;

  final List<CartSelectedProductModel> selectedProductList;

  const PaymentScreen({
    super.key,
    required this.total,
    required this.selectedProductList,
  });

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenConsumerState();
}

class _PaymentScreenConsumerState extends ConsumerState<PaymentScreen> {
  List<AddressModel> _addressList = [];
  AddressModel? _selectedAddress = null;

  //payment
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment({
    required AddressModel addressModel,
    required double total,
    required Map<String, dynamic>? paymentIntent,
  }) async {
    try {
      paymentIntent = await createPaymentIntent('${total.round()}', 'LKR');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Ecommerce App',
              billingDetails: BillingDetails(
                name: addressModel.fullName,
              ),
            ),
          )
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }






//navigation
  void navigateToBack(BuildContext context) {
    Navigator.pop(context);
  }

  void backtoHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

//show confirm Dialog
  // void showConfirmDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (_) => const OrderConfirmDialog(),
  //   );
  // }

  //show addEdit Dialog
  void addEditAddressDialog(AddressModel? address, int? index) {
    showDialog(
      context: context,
      builder: (_) => AddEditDialog(address: address, index: index),
    );
  }

  void refreshLocalAddressList() {
    ref
        .read(addressControllerProvider.notifier)
        .updateLocalAddressList(context: context);
  }

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        "pk_test_51NrzsTIQPKudrxJFbhL3IorS7XffhEm8KqHvup1961F3iHuzwQfU1Ub9eGevTjj16Y43AKuWG7VURSqEbXblupM100xaNZby3P";
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshLocalAddressList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _res = ref.watch(addressProvider);
    final size = MediaQuery.of(context).size;

    if (_res.isNotEmpty) {
      _addressList = _res;

      _selectedAddress ??= _res[0];
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              navigateToBack(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: blackColorShade1,
              size: 35,
            ),
          ),
          title: const Text(
            "Payment",
            style: TextStyle(
              color: blackColorShade1,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: backtoHome,
              icon: Icon(
                Icons.home_outlined,
                color: blackColorShade1,
                size: 30,
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Your Details',
                      style: TextStyle(
                          color: blackColorShade1,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                      child: Row(
                        children: [
                          _selectedAddress != null
                              ? Expanded(
                                  child: Row(
                                    children: [
                                      DropdownButton(
                                        value: _selectedAddress!.address,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: _addressList
                                            .map((AddressModel item) {
                                          return DropdownMenuItem(
                                            value: item.address,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${item.fullName.split(" ").elementAt(0)} ${item.address.split(" ").elementAt(0)}",
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? address) {
                                          setState(() {
                                            _selectedAddress = _addressList
                                                .firstWhere((element) =>
                                                    element.address == address);
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                            ),
                            onPressed: () => addEditAddressDialog(null, null),
                            child: const Text("Add New"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: size.height * 0.45,
                        child: CustomGridView(
                            productList: widget.selectedProductList)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          _selectedAddress != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("To :"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(_selectedAddress!.fullName),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                _selectedAddress!.mobileNumber),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(_selectedAddress!.address),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(_selectedAddress!.cityTown),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(_selectedAddress!.province),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "LKR: ${widget.total.round()}",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          _selectedAddress != null
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                    ),
                                    onPressed: () async {
                                      await makePayment(
                                        addressModel: _selectedAddress!,
                                        paymentIntent: paymentIntent,
                                        total: widget.total,
                                      );
                                    },
                                    child: const Text(
                                      'Pay Now',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: grayColor,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Pay Now',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
