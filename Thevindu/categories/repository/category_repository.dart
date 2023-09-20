import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controller/common_get_category_controller.dart';
import '../../../core/common/controller/common_get_product_controller.dart';

import '../../../model/product.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());

class CategoryRepository {
//get all product data
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
    return ref.read(categorizedProductListProvider(category));
  }

  //get category list
  Future<bool> getCategoryData(
      {required Ref ref, required BuildContext context}) async {
    return await ref
        .read(commonGetCategoryControllerProvider.notifier)
        .getCategoryData(context);
  }
}
