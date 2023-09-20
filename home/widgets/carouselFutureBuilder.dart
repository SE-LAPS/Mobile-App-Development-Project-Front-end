import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/loader.dart';
import '../../../model/product.dart';
import '../controller/home_controller.dart';
import 'carouselImage.dart';

class CarouselFutureBuilder extends ConsumerWidget {
  const CarouselFutureBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref
            .watch(homeControllerProvider.notifier)
            .getDiscountedProductData(),
        builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong! ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<ProductModel> products = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: CarouselImage(discountedProductList: products),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
