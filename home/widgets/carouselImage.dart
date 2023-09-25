import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import 'offer.dart';

class CarouselImage extends StatelessWidget {
  final List<ProductModel> discountedProductList;
  const CarouselImage({super.key, required this.discountedProductList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: discountedProductList.map((product) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: CachedNetworkImageProvider(product.images[0]),
                  fit: BoxFit.fitHeight,

                  // NetworkImage(
                  //   product.images[0],
                  // ),
                  // fit: BoxFit.fitHeight,
                ),
              ),
              child: Offer(product: product),
            ),
          ],
        );
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 160),
    );
  }
}
