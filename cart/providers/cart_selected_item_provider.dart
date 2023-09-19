//user provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/cart_selected_product_model.dart';

final cartSelectedItemProvider =
    StateProvider<List<CartSelectedProductModel>?>((ref) => []);
