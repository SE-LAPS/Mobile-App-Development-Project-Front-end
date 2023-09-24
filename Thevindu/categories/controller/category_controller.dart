import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';

import '../repository/category_repository.dart';

//authControllerProvider
final categoryControllerProvider =
    StateNotifierProvider<CategoryController, bool>(
  (ref) => CategoryController(
    categoryRepository: ref.watch(categoryRepositoryProvider),
    ref: ref,
  ),
);

class CategoryController extends StateNotifier<bool> {
  final CategoryRepository _categoryRepository;
  final Ref _ref;
  CategoryController(
      {required CategoryRepository categoryRepository, required Ref ref})
      : _categoryRepository = categoryRepository,
        _ref = ref,
        super(false);

//get all product data
  Future<List<ProductModel>> getAllProductData() {
    return _categoryRepository.getAllProductData(_ref);
  }

  //get categorized product data
  AsyncValue<List<ProductModel?>> getCategorizedProductData({
    required String category,
  }) {
    return _categoryRepository.getCategorizedProductData(
        category: category, ref: _ref);
  }

  //get category list
  Future<bool> getCategoryData(BuildContext context) async {
    return await _categoryRepository.getCategoryData(
        ref: _ref, context: context);
  }
}
