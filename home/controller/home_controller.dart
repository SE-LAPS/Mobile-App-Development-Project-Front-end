import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';
import '../repository/home_repository.dart';

//homeControllerProvider
final homeControllerProvider = StateNotifierProvider<HomeController, bool>(
  (ref) => HomeController(
    homeRepository: ref.watch(homeRepositoryProvider),
    ref: ref,
  ),
);

class HomeController extends StateNotifier<bool> {
  final HomeRepository _homeRepository;
  final Ref _ref;
  HomeController({required HomeRepository homeRepository, required Ref ref})
      : _homeRepository = homeRepository,
        _ref = ref,
        super(false);

//get all product data
  Future<List<ProductModel>> getAllProductData() {
    return _homeRepository.getAllProductData(_ref);
  }

  //get categorized product data
  AsyncValue<List<ProductModel?>> getCategorizedProductData({
    required String category,
  }) {
    return _homeRepository.getCategorizedProductData(
        category: category, ref: _ref);
  }

  //get discounted product data
  Future<List<ProductModel>> getDiscountedProductData() {
    return _homeRepository.getDiscountedProductData(ref: _ref);
  }

  //get Category list
  Future<bool> getCategoryData(BuildContext context) async {
    return await _homeRepository.getCategoryData(ref: _ref, context: context);
  }
}
