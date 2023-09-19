import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product.dart';

import '../repository/search_repository.dart';

//authControllerProvider
final searchControllerProvider = StateNotifierProvider<SearchController, bool>(
  (ref) => SearchController(
    searchRepository: ref.watch(searchRepositoryProvider),
    ref: ref,
  ),
);

//streamProvider
final searchProviderStream = StreamProvider.autoDispose<List<ProductModel?>>(
  (ref) {
    final _searchController = ref.watch(searchControllerProvider.notifier);
    return _searchController.getSearchData();
  },
);

class SearchController extends StateNotifier<bool> {
  final SearchRepository _searchRepository;
  final Ref _ref;
  SearchController(
      {required SearchRepository searchRepository, required Ref ref})
      : _searchRepository = searchRepository,
        _ref = ref,
        super(false);

  //get categorized product data
  Stream<List<ProductModel?>> getSearchData() {
    return _searchRepository.getSearchData();
  }
}
