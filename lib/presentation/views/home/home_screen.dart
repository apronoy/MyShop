import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_sizes.dart';
import 'package:my_product/core/utils/app_colors.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';
import 'package:my_product/presentation/views/notification/notification.dart';
import 'package:my_product/presentation/views/widgets/banner_widget.dart';
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
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,

        title: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
              onBackgroundImageError: (_, __) {
                // fallback handled below
              },
              child: null,
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wellcome to',
                  style: GoogleFonts.montserrat(
                    fontSize: searchFontSize,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Easy Shop',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: titleFontSize,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.spacingLarge),
            child: GestureDetector(
              onTap: () {
                Get.to(() => NotificationPage());
              },
              child: const Icon(
                Icons.notifications_active_rounded,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Container(
            // padding: EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.background,
                  AppColors.surface,
                  AppColors.card,
                ],
              ),
            ),
          ),

          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentLight.withOpacity(0.12),
              ),
            ),
          ),

          Positioned(
            bottom: -80,
            left: -50,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.06),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  // SliverPersistentHeader(
                  //   pinned: true,
                  //   delegate: SearchBarDelegate(
                  //     child: _searchBar(
                  //       horizontalPadding,
                  //       borderRadius,
                  //       searchFontSize,
                  //     ),
                  //   ),
                  // ),
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: Obx(
                      () => ProductBanner(products: controller.bannerProducts),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 10)),

                  SliverToBoxAdapter(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (controller.isError.value) {
                        return Center(
                          child: Column(
                            children: [
                              const Text(
                                "Failed to load products",
                                style: TextStyle(color: AppColors.textPrimary),
                              ),
                              const SizedBox(height: 12),
                              IconButton(
                                onPressed: controller.loadProducts,
                                icon: const Icon(
                                  Icons.refresh,
                                  color: AppColors.textPrimary,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (controller.filteredProducts.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(40),
                          child: Text(
                            "No products found",
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                        );
                      }

                      return Column(
                        children: categories.map((category) {
                          return CategorySection(
                            title: category.contains("'s")
                                ? category.split("'s").first.capitalizeFirst!
                                : category.capitalizeFirst!,
                            products: controller.filteredProducts
                                .where(
                                  (p) => p.category.toLowerCase() == category,
                                )
                                .toList(),
                          );
                        }).toList(),
                      );
                    }),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 70)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
