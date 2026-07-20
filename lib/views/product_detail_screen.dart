import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/cart_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  void _addToCart(BuildContext context) {
    CartService.instance.addProduct(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title ?? ''} sepete eklendi.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ürün Detayı')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.1,
                    child: Center(
                      child: Image.network(
                        product.image ?? '',
                        fit: BoxFit.contain,
                        errorBuilder:
                            (
                              BuildContext context,
                              Object error,
                              StackTrace? stackTrace,
                            ) {
                              return const Icon(
                                Icons.image_not_supported_outlined,
                                size: 72,
                              );
                            },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    product.title ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Chip(label: Text(product.category ?? '')),
                  const SizedBox(height: 12),
                  Text(
                    product.description ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Text(
                        '\$${(product.price ?? 0).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text((product.rating?.rate ?? 0).toStringAsFixed(1)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _addToCart(context),
                      icon: const Icon(Icons.add_shopping_cart_outlined),
                      label: const Text('Sepete Ekle'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
