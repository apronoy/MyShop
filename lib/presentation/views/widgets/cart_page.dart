import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_product/core/utils/app_sizes.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key, required this.allproduct});

  final controller = Get.find<ProductController>();
  final ProductController allproduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = controller.favoriteProducts;

        if (items.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.spacingXXLarge,
              ),
              child: Text(
                'Your cart is empty. Tap the heart icon to add a product to the cart.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: AppSizes.fontRegular),
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingNormal),
          itemCount: items.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final product = items[index];
            return ListTile(
              onTap: () {
                Get.toNamed(
                  '/detail',
                  arguments: allproduct.products.firstWhere(
                    (p) => p.id == product.id,
                  ),
                );
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spacingXLarge,
                vertical: AppSizes.spacingNormal,
              ),
              leading: CachedNetworkImage(
                imageUrl: product.image,
                width: 60,
                fit: BoxFit.contain,
                placeholder: (context, url) => const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image),
              ),
              title: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  controller.toggleFavorite(product.id);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
