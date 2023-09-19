// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../core/palette.dart';
// import '../../../model/cart_selected_product_model.dart';

// import '../../payment/screens/payment_screen.dart';

// import '../controller/cart_controller.dart';
// import '../providers/cart_selected_item_provider.dart';
// import '../widgets/customGridView.dart';

// class CartScreen extends ConsumerStatefulWidget {
//   static const String routeName = "/cart-screen";
//   const CartScreen({super.key});

//   @override
//   ConsumerState<CartScreen> createState() => _CartScreenConsumerState();
// }

// class _CartScreenConsumerState extends ConsumerState<CartScreen> {
//   final stickyKey = GlobalKey();

//   void navigateToBack(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void navigateToPaymentScreen() {
//     Navigator.pushNamed(context, PaymentScreen.routeName);
//   }

//   void refreshCartList() {
//     ref.read(cartControllerProvider.notifier).updateCartList(context: context);
//   }

//   void addCartItemToSelectedItemProvider() {
//     ref.read(cartSelectedItemProvider.notifier).update((state) {
//       final cartList = ref.read(cartProvider);
//       state = cartList.map((cartProduct) {
//         return CartSelectedProductModel(
//             id: cartProduct.id,
//             name: cartProduct.name,
//             description: cartProduct.description,
//             category: cartProduct.category,
//             sellerUserId: cartProduct.sellerUserId,
//             images: cartProduct.images,
//             price: cartProduct.price,
//             quantity: cartProduct.quantity,
//             kg: cartProduct.kg,
//             shippingCategory: cartProduct.shippingCategory,
//             isSelected: true,
//             selectedQuantity: 1);
//       }).toList();
//     });
//     print("${ref.read(cartSelectedItemProvider)}");
//   }

//   @override
//   void initState() {
//     super.initState();
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       refreshCartList();
//       addCartItemToSelectedItemProvider();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<CartSelectedProductModel>? selectedItem =
//         ref.watch(cartSelectedItemProvider);
//     int selectedItems = 0;
//     double subTotal = 0.0;
//     int discount = 0;
//     int discountPrice = 0;
//     double shippingCost = 0.0;
//     double total = 0.0;

//     //calculation
//     if (selectedItem != null && selectedItem.isNotEmpty) {
//       //selected item
//       selectedItems = selectedItem.length;

//       for (CartSelectedProductModel product in selectedItem) {
//         //SubTotal
//         subTotal += product.price;
//         if (product.discount != null) {
//           discountPrice += product.discount!;
//         }
//       }

//       //Discount percentage
//       final subTotalPrice = subTotal.round();
//       final afterDiscount = subTotalPrice - discountPrice;
//       discount =
//           ((subTotalPrice - afterDiscount) / subTotalPrice * 100).round();

//       //   //For shippingCost
//       List<String> sellerIdList = [];
//       selectedItem.forEach((element) {
//         sellerIdList.add(element.sellerUserId);
//       });
//       sellerIdList = sellerIdList.toSet().toList();

//       List<double> shippingPriceList = [];

//       for (var i = 0; i < sellerIdList.length; i++) {
//         List<double> tempShippingPriceList = [];
//         for (var element in selectedItem) {
//           if (element.sellerUserId == sellerIdList[i]) {
//             tempShippingPriceList.add(element.shippingCategory.price);
//           }
//           tempShippingPriceList = tempShippingPriceList.toSet().toList();
//         }
//         shippingPriceList.addAll(tempShippingPriceList);
//       }
//       if (shippingPriceList.isNotEmpty) {
//         shippingCost =
//             shippingPriceList.reduce((value, element) => value + element);
//       }

//       total = subTotal - discountPrice + shippingCost;
//     }

//     var fontSize = const TextStyle(fontSize: 15);

//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading: IconButton(
//             onPressed: () {
//               navigateToBack(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_rounded,
//               color: blackColorShade1,
//               size: 35,
//             ),
//           ),
//           title: const Text(
//             "Cart",
//             style: TextStyle(
//                 color: blackColorShade1,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w500),
//           ),
//           elevation: 0,
//         ),
//         body: selectedItem!.isNotEmpty
//             ? SingleChildScrollView(
//                 physics: const ScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       ConstrainedBox(
//                         constraints:
//                             BoxConstraints(maxHeight: size.height * 0.6),
//                         child: CustomGridView(
//                           productList: selectedItem,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Selected Items ($selectedItems)',
//                                     style: fontSize,
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   discount != 0
//                                       ? Text(
//                                           'Discount',
//                                           style: fontSize,
//                                         )
//                                       : const SizedBox(),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text('Shipping', style: fontSize),
//                                 ],
//                               ),
//                               Column(
//                                 key: stickyKey,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     'Sub Total : \$ $subTotal',
//                                     style: fontSize,
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   discount != 0
//                                       ? Text(
//                                           '\$ $discountPrice ($discount%)',
//                                           style: fontSize,
//                                         )
//                                       : const SizedBox(),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   shippingCost != 0
//                                       ? Text(
//                                           '\$ $shippingCost',
//                                           style: fontSize,
//                                         )
//                                       : Text(
//                                           'Free shipping : \$ $shippingCost',
//                                           style: fontSize,
//                                         ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           const Divider(
//                             thickness: 1.5,
//                             color: blackColorShade1,
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Total',
//                                 style: fontSize,
//                               ),
//                               Text(
//                                 '\$ $total',
//                                 style: fontSize,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: size.height * 0.04,
//                           ),
//                           selectedItems != 0
//                               ? SizedBox(
//                                   width: double.infinity,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       backgroundColor: primaryColor,
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 15,
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       navigateToPaymentScreen();
//                                     },
//                                     child: const Text(
//                                       'Checkout',
//                                       style: TextStyle(fontSize: 25),
//                                     ),
//                                   ),
//                                 )
//                               : SizedBox(
//                                   width: double.infinity,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       backgroundColor: grayColor,
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 15,
//                                       ),
//                                     ),
//                                     onPressed: () {},
//                                     child: const Text(
//                                       'Checkout',
//                                       style: TextStyle(fontSize: 25),
//                                     ),
//                                   ),
//                                 ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     SizedBox(
//                       height: 120,
//                       width: 120,
//                       child: Icon(
//                         Icons.mood_bad_rounded,
//                         size: 100,
//                         color: Color.fromARGB(255, 226, 226, 226),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text('No products'),
//                   ],
//                 ),
//               ));
//   }
// }
