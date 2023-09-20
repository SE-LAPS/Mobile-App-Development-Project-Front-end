import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/loader.dart';
import '../../../model/product.dart';
import '../controller/home_controller.dart';
import 'customGridView.dart';

class ProductFutureBuilder extends ConsumerWidget {
  final String? category;

  const ProductFutureBuilder({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return category != null
        ? ref
            .watch(homeControllerProvider.notifier)
            .getCategorizedProductData(category: category!)
            .when(
                data: (snapshot) => whenData(snapshot),
                error: (error, stackTrace) => whenError(error),
                loading: () => whenLoading())
        : FutureBuilder(
            future:
                ref.watch(homeControllerProvider.notifier).getAllProductData(),
            builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return whenLoading();
              } else if (snapshot.hasError) {
                return whenError(snapshot.error);
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return whenData(snapshot);
              } else {
                return const SizedBox();
              }
            });
  }

  //when error
  Widget whenError(dynamic error) {
    return Center(
      child: Text('Something went wrong! ${error}'),
    );
  }

  //when data
  Widget whenData(dynamic snapshot) {
    List<ProductModel?> products = snapshot.runtimeType == (List<ProductModel?>)
        ? snapshot
        : snapshot.data;

    return products.isNotEmpty
        ? CustomGridView(
            productList: products, categoryName: category ?? "Trending")
        : const SizedBox();
  }

  //when loading
  Widget whenLoading() {
    return const Loader();
  }
}
