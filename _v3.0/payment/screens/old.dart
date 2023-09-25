import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../model/card_model.dart';
import '../widgets/carouselImage.dart';
import '../widgets/order_confirm_dialog_box.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
//Carousel
  CarouselController _cardController = CarouselController();

//navigation
  void navigateToBack(BuildContext context) {
    Navigator.pop(context);
  }

  List<CardModel> cards = [
    CardModel(
        cardType: 'visa', cardImage: 'assets/images/payment/visacard.png'),
    CardModel(
        cardType: 'master', cardImage: 'assets/images/payment/mastercard.png'),
    CardModel(
        cardType: 'american_express',
        cardImage: 'assets/images/payment/american_express.png'),
  ];

//show confirm Dialog
  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => const OrderConfirmDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var formTextStyle = const TextStyle(fontSize: 16);
    return Scaffold(
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
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselImage(cards: cards, cardController: _cardController),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add a new payment method',
                    style: TextStyle(
                        color: blackColorShade1,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: blackColorShade2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset(
                                      'assets/images/payment/american_express_logo.jpeg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: blackColorShade2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset(
                                      'assets/images/payment/visacard_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: blackColorShade2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset(
                                      'assets/images/payment/mastercard_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        onLongPress: () {},
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: const DecoratedBox(
                              decoration:
                                  BoxDecoration(color: blackColorShade2),
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Number',
                          style: formTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: blackColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 8),
                            isDense: true,
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor, width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor, width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expiry Date',
                                    style: formTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    cursorColor: blackColor,
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 8),
                                      isDense: true,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: blackColor, width: 2),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: blackColor, width: 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CVV',
                                    style: formTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    cursorColor: blackColor,
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 8),
                                      isDense: true,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: blackColor, width: 2),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: blackColor, width: 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Card Number',
                          style: formTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: blackColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 8),
                            isDense: true,
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor, width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor, width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Select Cart Information',
                              style: formTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: formTextStyle,
                            ),
                            Text(
                              '\Rs:149.93',
                              style: formTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
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
                              showConfirmDialog();
                            },
                            child: Text(
                              'Pay Now',
                              style: formTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
