import 'package:ecommerce_app/features/payment/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/palette.dart';
import '../../../model/cart_selected_product_model.dart';

import '../../home/widgets/bottom_bar.dart';

import '../controller/cart_controller.dart';
import '../providers/cart_selected_item_provider.dart';
import '../widgets/customGridView.dart';

class CartScreen extends ConsumerStatefulWidget {
  static const String routeName = "/cart-screen";
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenConsumerState();
}

class _CartScreenConsumerState extends ConsumerState<CartScreen> {
//navigation
  void backtoHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

  void navigateToBack(BuildContext context) {
    Navigator.pop(context);
  }

  void navigateToPaymentScreen({
    required double total,
    required List<CartSelectedProductModel> selectedProductList,
  }) {
    Navigator.pushNamed(
      context,
      PaymentScreen.routeName,
      arguments: [total, selectedProductList],
    );
  }

  //button press
  void checkoutButtonPress(
      {required double total,
      required List<CartSelectedProductModel> selectedItem}) {
    navigateToPaymentScreen(total: total, selectedProductList: selectedItem);
  }

  void refreshCartList() {
    ref.read(cartControllerProvider.notifier).updateCartList(context: context);
  }

  void addCartItemToSelectedItemProvider() {
    ref.read(cartSelectedItemProvider.notifier).update((state) {
      final cartList = ref.read(cartProvider);
      state = cartList.map((cartProduct) {
        return CartSelectedProductModel(
            id: cartProduct.id,
            name: cartProduct.name,
            description: cartProduct.description,
            category: cartProduct.category,
            sellerUserId: cartProduct.sellerUserId,
            images: cartProduct.images,
            price: cartProduct.price,
            quantity: cartProduct.quantity,
            kg: cartProduct.kg,
            shippingCategory: cartProduct.shippingCategory,
            isSelected: true,
            dateTime: cartProduct.dateTime,
            discount: cartProduct.discount,
            rating: cartProduct.rating,
            selectedQuantity: 1);
      }).toList();

      return state;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshCartList();
      addCartItemToSelectedItemProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            "Cart",
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
        body: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: size.height, maxWidth: size.width),
            child: bodyContent(context)),
      ),
    );
  }

  Widget bodyContent(BuildContext context) {
    Widget returnData = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            height: 120,
            width: 120,
            child: Icon(
              Icons.mood_bad_rounded,
              size: 100,
              color: Color.fromARGB(255, 226, 226, 226),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('No products'),
        ],
      ),
    );

    final List<CartSelectedProductModel>? cartProducts =
        ref.watch(cartProvider).map((cartProduct) {
      return CartSelectedProductModel(
          id: cartProduct.id,
          name: cartProduct.name,
          description: cartProduct.description,
          category: cartProduct.category,
          sellerUserId: cartProduct.sellerUserId,
          images: cartProduct.images,
          price: cartProduct.price,
          quantity: cartProduct.quantity,
          kg: cartProduct.kg,
          shippingCategory: cartProduct.shippingCategory,
          isSelected: true,
          discount: cartProduct.discount,
          dateTime: cartProduct.dateTime,
          rating: cartProduct.rating,
          selectedQuantity: 1);
    }).toList();
    ;
    final List<CartSelectedProductModel>? selectedItem =
        ref.watch(cartSelectedItemProvider);

    int selectedItems = 0;
    double subTotal = 0.0;
    int discount = 0;
    int discountPrice = 0;
    double shippingCost = 0.0;
    double total = 0.0;

    //calculation
    if (selectedItem != null && selectedItem.isNotEmpty) {
      //selected Item
      selectedItems = selectedItem.length;
      for (CartSelectedProductModel product in selectedItem) {
        //SubTotal
        subTotal += product.price * product.selectedQuantity;
        if (product.discount != null) {
          discountPrice += product.discount!;
        }
      }

      //Discount percentage
      final subTotalPrice = subTotal.round();
      final afterDiscount = subTotalPrice - discountPrice;
      discount =
          ((subTotalPrice - afterDiscount) / subTotalPrice * 100).round();

      //For shippingCost
      List<String> sellerIdList = [];
      selectedItem.forEach((element) {
        sellerIdList.add(element.sellerUserId);
      });
      sellerIdList = sellerIdList.toSet().toList();

      List<double> shippingPriceList = [];

      for (var i = 0; i < sellerIdList.length; i++) {
        List<double> tempShippingPriceList = [];
        for (var element in selectedItem) {
          if (element.sellerUserId == sellerIdList[i]) {
            tempShippingPriceList.add(element.shippingCategory.price);
          }
          tempShippingPriceList = tempShippingPriceList.toSet().toList();
        }
        shippingPriceList.addAll(tempShippingPriceList);
      }
      if (shippingPriceList.isNotEmpty) {
        shippingCost =
            shippingPriceList.reduce((value, element) => value + element);
      }

      total = subTotal - discountPrice + shippingCost;
    } else {
      //selected item
      selectedItems = 0;
    }

    if (cartProducts != null && cartProducts.isNotEmpty) {
      var fontSize = const TextStyle(fontSize: 15);
      // final int cartItems = cartProducts.length;
      final size = MediaQuery.of(context).size;
      returnData = CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.5,
                    child: CustomGridView(
                      productList: cartProducts,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Items ($selectedItems)',
                                  style: fontSize,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                discount != 0
                                    ? Text(
                                        'Discount',
                                        style: fontSize,
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Shipping', style: fontSize),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Sub Total : \Rs: $subTotal',
                                  style: fontSize,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                discount != 0
                                    ? Text(
                                        '\Rs: $discountPrice ($discount%)',
                                        style: fontSize,
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                shippingCost != 0
                                    ? Text(
                                        '\Rs; $shippingCost',
                                        style: fontSize,
                                      )
                                    : Text(
                                        'Free shipping : \Rs: $shippingCost',
                                        style: fontSize,
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: blackColorShade1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: fontSize,
                            ),
                            Text(
                              '\Rs: ${total.round()}',
                              style: fontSize,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        selectedItems != 0
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
                                  onPressed: () {
                                    checkoutButtonPress(
                                        total: total,
                                        selectedItem: selectedItem!);
                                  },
                                  child: const Text(
                                    'Checkout',
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
                                    'Checkout',
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
      );
    }

    return returnData;
  }
}
