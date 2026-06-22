import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_colors.dart';
import 'package:my_product/core/utils/app_sizes.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';
import 'package:my_product/presentation/views/widgets/appbar.dart';
import 'package:my_product/presentation/views/widgets/search_bar_delegence.dart';

class ProductSection extends StatelessWidget {
  ProductSection({super.key, this.isback});

  final ProductController controller = Get.find<ProductController>();
  final bool? isback;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final searchFontSize = size.width > 700
        ? AppSizes.fontRegular
        : AppSizes.fontSmall;

    final borderRadius = BorderRadius.circular(AppSizes.borderRadiusMedium);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.isError.value) {
          return const Center(child: Text("Failed to load products"));
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                App_bar(Title: 'Products', isback: isback),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SearchBarDelegate(
                          child: _searchBar(borderRadius, searchFontSize),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 10)),

                      // CATEGORY ICONS
                      SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              _categoryIcon(Icons.man, 'Man'),

                              _categoryIcon(Icons.woman, 'Women'),

                              _categoryIcon(
                                Icons.electrical_services_rounded,
                                ' Electronic',
                              ),

                              _categoryIcon(Icons.diamond, ' Juyelary'),
                            ],
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 15)),

                      // PRODUCT GRID
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = controller.filteredProducts[index];

                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('/detail', arguments: product);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Colors.grey.shade200),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Image.network(
                                                product.image,
                                                // height: 120,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -18,
                                            right: -18,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Obx(() {
                                                final isFav = controller
                                                    .isFavorite(product.id);
                                                return IconButton(
                                                  onPressed: () {
                                                    controller.toggleFavorite(
                                                      product.id,
                                                    );
                                                  },
                                                  icon: isFav
                                                      ? Icon(Icons.favorite)
                                                      : Icon(
                                                          Icons.favorite_border,
                                                        ),
                                                  color: isFav
                                                      ? Colors.red
                                                      : Colors.grey,
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        // vertical: 10,
                                      ),
                                      child: Text(
                                        product.title,
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${product.price}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                product.rating.toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }, childCount: controller.filteredProducts.length),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.70,
                            ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 75)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _categoryIcon(IconData icon, String label) {
    return Container(
      height: 40,

      decoration: BoxDecoration(
        color: AppColors.primaryVariant,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, size: 25, color: AppColors.white),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BorderRadius borderRadius, double searchFontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.spacingSmall),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,

              color: Colors.white.withOpacity(0.18),

              border: Border.all(
                color: Colors.white.withOpacity(0.35),
                width: 1.2,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: TextField(
              onChanged: controller.search,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: "Search products Catagory",
                hintStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: searchFontSize,
                  color: AppColors.textSecondary,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacingLarge,
                  vertical: AppSizes.spacingLarge,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
