// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/common/widgets/stars.dart';
import '../../../core/palette.dart';
import '../../../model/product.dart';

class SearchedProduct extends StatelessWidget {
  final ProductModel product;
  final int searchingTextLength;
  const SearchedProduct({
    Key? key,
    required this.product,
    required this.searchingTextLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating = product.rating;
    double? avgRating;

    if (rating != null) {
      double totalRating = 0;
      for (int i = 0; i < product.rating!.length; i++) {
        totalRating += product.rating![i].rating;
      }

      if (totalRating != 0) {
        avgRating = totalRating / product.rating!.length;
      }
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: RichText(
                      text: TextSpan(
                        text: product.name.substring(0, searchingTextLength),
                        style: const TextStyle(
                            color: blackColor, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: product.name.substring(searchingTextLength),
                            style: const TextStyle(color: grayColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: avgRating != null
                        ? Stars(rating: avgRating)
                        : const SizedBox(),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\Rs:${product.price}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
