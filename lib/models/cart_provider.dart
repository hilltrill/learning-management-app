import 'package:flutter/widgets.dart';

import 'cart_model.dart';

class CartProvider extends InheritedNotifier<CartModel> {
  const CartProvider({
    super.key,
    required super.child,
    required CartModel notifier,
  }) : super(notifier: notifier);

  static CartModel of(BuildContext context) {
    final CartProvider? result =
        context.dependOnInheritedWidgetOfExactType<CartProvider>();
    assert(result != null, 'No CartProvider found in context');
    return result!.notifier!;
  }
}
