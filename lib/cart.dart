import 'models/product.dart';

class CartItem {
  CartItem({required this.product, this.quantity = 1});

  final Product product;
  int quantity;

  int get sum => product.price * quantity;
}

class Cart {
  final List<CartItem> items = [];

  void add(Product product, int quantity) {
    for (final item in items) {
      if (item.product.id == product.id) {
        item.quantity += quantity;
        return;
      }
    }
    items.add(CartItem(product: product, quantity: quantity));
  }

  void remove(CartItem item) => items.remove(item);

  int get count => items.fold<int>(0, (total, item) => total + item.quantity);
  int get total => items.fold<int>(0, (total, item) => total + item.sum);
}

// Один спільний кошик для всіх екранів застосунку
final cart = Cart();