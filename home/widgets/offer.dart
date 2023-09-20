import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import 'my_custom_clipper.dart';

class Offer extends StatelessWidget {
  final ProductModel product;
  const Offer({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final originalPrice = product.price.round();
    final afterDiscount = originalPrice - product.discount!;
    final offerPrecentage =
        ((originalPrice - afterDiscount) / originalPrice * 100).round();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.50,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            color: primaryColor.withOpacity(0.25),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get $offerPrecentage%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25)),
                      onPressed: () {},
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
