// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/common/widgets/product_card.dart';
import '../../../model/product.dart';

class CustomGridView extends StatelessWidget {
  final String categoryName;
  final List<ProductModel?> productList;
  const CustomGridView({
    Key? key,
    required this.categoryName,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isProductNull = productList.isEmpty;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 12,
            ),
            child: Text(
              categoryName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          isProductNull == false
              ? SizedBox(
                  height: size.height / 2.1,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: size.width / (size.height / 4),
                      mainAxisExtent: size.width / 2.5,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return GestureDetector(
                        onTap: (() {}),
                        child: ProductCard(
                          product: product!,
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
