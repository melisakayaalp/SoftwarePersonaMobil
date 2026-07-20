import '../models/product_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({ProductModel? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartService {
  CartService._internal();

  static final CartService instance = CartService._internal();

  final Map<int, CartItem> _cartItems = <int, CartItem>{};

  List<CartItem> get items => _cartItems.values.toList(growable: false);

  void addProduct(ProductModel product) {
    final int productId = product.id ?? 0;
    final CartItem? existingItem = _cartItems[productId];

    if (existingItem == null) {
      _cartItems[productId] = CartItem(product: product, quantity: 1);
      return;
    }

    _cartItems[productId] = existingItem.copyWith(
      quantity: existingItem.quantity + 1,
    );
  }

  void removeProduct(ProductModel product) {
    _cartItems.remove(product.id ?? 0);
  }

  int getQuantity(int productId) {
    return _cartItems[productId]?.quantity ?? 0;
  }

  double getTotalAmount() {
    return _cartItems.values.fold<double>(
      0,
      (double total, CartItem item) =>
          total + ((item.product.price ?? 0) * item.quantity),
    );
  }
}
