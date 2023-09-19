import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../model/product.dart';

final searchRepositoryProvider =
    Provider((ref) => SearchRepository(firestore: ref.read(firestoreProvider)));

class SearchRepository {
  final FirebaseFirestore _firestore;
  SearchRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productCollection);

  //get searchProduct data
  Stream<List<ProductModel?>> getSearchData() {
    return _products.orderBy("name").snapshots().map((event) => event.docs
        .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }
}
