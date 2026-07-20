import 'package:flutter/material.dart';

import '../components/mini_card_tile.dart';
import '../services/cart_service.dart';
import 'pay_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _removeItem(CartItem item) {
    CartService.instance.removeProduct(item.product);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<CartItem> cartItems = CartService.instance.items;
    final double totalAmount = CartService.instance.getTotalAmount();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepetim'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text('Sepetiniz boş.'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final CartItem cartItem = cartItems[index];

                        return MiniCardTile(
                          cartItem: cartItem,
                          onDelete: () => _removeItem(cartItem),
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black12,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Toplam Tutar',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: cartItems.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const PayScreen(),
                              ),
                            );
                          },
                    child: const Text('Ödeme Yap'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}