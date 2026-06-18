import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_colors.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key, required this.allproduct});

  final controller = Get.find<ProductController>();
  final ProductController allproduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Cart',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = controller.favoriteProducts;

        if (items.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Your cart is empty. Tap the heart icon to add a product to the cart.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(),
          itemBuilder: (context, index) {
            final product = items[index];
            return Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    '/detail',
                    arguments: allproduct.products.firstWhere(
                      (p) => p.id == product.id,
                    ),
                  );
                },
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: product.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        controller.toggleFavorite(product.id);
                      },
                      icon: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
