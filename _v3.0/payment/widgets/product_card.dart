// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../../../model/cart_selected_product_model.dart';

class ProductCard extends StatelessWidget {
  final CartSelectedProductModel product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: blackColorShade2,
        ),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              // child: Image.network(
              //   product.images[0],
              // ),
              child: CachedNetworkImage(
                key: UniqueKey(),
                imageUrl: product.images[0],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(fontSize: 15, color: blackColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '\Rs: ${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 15, color: primaryColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        product.kg != null
                            ? "${product.kg!.toStringAsFixed(2)}kg x ${product.selectedQuantity}"
                            : "1 x ${product.selectedQuantity}",
                        style: TextStyle(fontSize: 10, color: blackColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.kg != null
                              ? "${(product.kg! * product.selectedQuantity).toStringAsFixed(2)} kg"
                              : "${product.selectedQuantity}",
                          style: TextStyle(fontSize: 20, color: blackColor),
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
