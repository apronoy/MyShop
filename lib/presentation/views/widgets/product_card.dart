import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_sizes.dart';
import 'package:my_product/data/models/product_model.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final imageHeight = cardWidth * 0.35;
        final titleFontSize = cardWidth > 300 ? 16.0 : 14.0;
        final priceFontSize = cardWidth > 300 ? 18.0 : 16.0;
        final ratingFontSize = cardWidth > 300 ? 14.0 : 12.0;

        return GestureDetector(
          onTap: () {
            Get.toNamed('/detail', arguments: product);
          },
          child: Card(
            margin: const EdgeInsets.all(AppSizes.spacingSmall),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingNormal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Obx(() {
                      return IconButton(
                        icon: Icon(
                          controller.isFavorite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        onPressed: () {
                          controller.toggleFavorite(product.id);
                        },
                        color: controller.isFavorite(product.id)
                            ? Colors.red
                            : Colors.black,
                      );
                    }),
                  ),

                  SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.spacingXSmall),

                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: titleFontSize,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: priceFontSize,
                        ),
                      ),

                      Text(
                        '⭐ ${product.rating}',
                        style: GoogleFonts.montserrat(fontSize: ratingFontSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
