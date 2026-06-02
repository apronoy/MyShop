import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_sizes.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';
import 'package:my_product/presentation/views/cart_page.dart';
import 'package:my_product/presentation/views/widgets/catagory_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<ProductController>();

  final categories = [
    "men's clothing",
    "women's clothing",
    "jewelery",
    "electronics",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = (size.width * 0.05).clamp(
      AppSizes.spacingLarge,
      AppSizes.spacingXXLarge,
    );
    final titleFontSize = size.width > 700
        ? AppSizes.fontXXLarge
        : AppSizes.fontXLarge;
    final searchFontSize = size.width > 700
        ? AppSizes.fontRegular
        : AppSizes.fontSmall;
    final borderRadius = BorderRadius.circular(AppSizes.borderRadiusMedium);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Shop',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: titleFontSize,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.spacingLarge),
            child: GestureDetector(
              onTap: () {
                Get.to(() => CartPage(allproduct: controller));
              },
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          search_bar(horizontalPadding, borderRadius, searchFontSize),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.isError.value) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Failed to load products"),
                      const SizedBox(height: AppSizes.spacingMedium),
                      GestureDetector(
                        onTap: controller.loadProducts,
                        child: const Icon(Icons.refresh, size: 50),
                      ),
                    ],
                  ),
                );
              }

              if (controller.filteredProducts.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return RefreshIndicator(
                onRefresh: controller.loadProducts,
                child: ListView(
                  children: categories.map((category) {
                    return CategorySection(
                      title: category.contains("'s")
                          ? category.split("'s").first.capitalizeFirst!
                          : category.capitalizeFirst!,
                      products: controller.filteredProducts
                          .where((p) => p.category.toLowerCase() == category)
                          .toList(),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Padding search_bar(
    double horizontalPadding,
    BorderRadius borderRadius,
    double searchFontSize,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: AppSizes.spacingSmall,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: const Color(0x14000000),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: controller.search,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: 'Search products',

            hintStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: searchFontSize,
              color: Colors.grey.shade500,
            ),

            prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),

            filled: true,
            fillColor: Colors.white,

            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: Colors.grey.shade700, width: 1.5),
            ),

            border: OutlineInputBorder(borderRadius: borderRadius),

            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSizes.spacingLarge,
              horizontal: AppSizes.spacingLarge,
            ),
          ),
        ),
      ),
    );
  }
}
