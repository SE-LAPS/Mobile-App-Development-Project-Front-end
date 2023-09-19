import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/firebase_providers.dart';

final accountRepositoryProvider = Provider(
  (ref) => AccountRepository(
    firestore: ref.read(firestoreProvider),
  ),
);

class AccountRepository {
  final FirebaseFirestore _firestore;

  AccountRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
}
