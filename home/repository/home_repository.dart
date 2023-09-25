import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controller/common_get_category_controller.dart';
import '../../../core/common/controller/common_get_product_controller.dart';

import '../../../model/product.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository());

class HomeRepository {
//get all product data//TEMP CODE
  Future<List<ProductModel>> getAllProductData(Ref ref) {
    return ref
        .read(commonGetProductControllerProvider.notifier)
        .getAllProductData();
  }

  //get categorized product data
  AsyncValue<List<ProductModel?>> getCategorizedProductData({
    required Ref ref,
    required String category,
  }) {
    return ref.watch(categorizedProductListProvider(category));
  }

  //get Discounted product data
  Future<List<ProductModel>> getDiscountedProductData({
    required Ref ref,
  }) {
    return ref
        .read(commonGetProductControllerProvider.notifier)
        .getDiscountedProductData();
  }

  //get Category list
  Future<bool> getCategoryData(
      {required Ref ref, required BuildContext context}) async {
    return await ref
        .read(commonGetCategoryControllerProvider.notifier)
        .getCategoryData(context);
  }
}
