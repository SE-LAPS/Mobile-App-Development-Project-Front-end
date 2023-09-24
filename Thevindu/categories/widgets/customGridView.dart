// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/common/widgets/product_card.dart';
import '../../../model/product.dart';

class CustomGridView extends StatelessWidget {
  final String? categoryName;
  final List<ProductModel?> productList;
  const CustomGridView({
    Key? key,
    this.categoryName,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isProductNull = productList[0] == null;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          (categoryName != null && isProductNull == false)
              ? Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 12,
                  ),
                  child: Text(
                    categoryName!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                )
              : const SizedBox(),
          isProductNull == false
              ? GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: size.width / (size.height / 4),
                    mainAxisExtent: size.width / 2.2,
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
                )
              : Center(
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
                ),
        ],
      ),
    );
  }
}
