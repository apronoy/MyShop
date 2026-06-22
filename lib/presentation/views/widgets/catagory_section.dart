import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_sizes.dart';
import 'package:my_product/presentation/views/products/all_product.dart';
import 'package:my_product/presentation/views/widgets/product_card.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List products;

  const CategorySection({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingSmall,
            vertical: AppSizes.spacingMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: AppSizes.fontXXLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ProductSection(isback: true));
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.montserrat(fontSize: AppSizes.fontSmall),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: AppSizes.cardSectionHeight,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (_, index) {
              return SizedBox(
                width: AppSizes.cardWidth,
                child: ProductCard(products[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
