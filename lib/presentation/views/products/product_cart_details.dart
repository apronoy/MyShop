import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_sizes.dart';
import 'package:my_product/data/models/product_model.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_product/core/utils/app_colors.dart';
import 'package:readmore/readmore.dart';

class ProductCartDetails extends StatelessWidget {
  const ProductCartDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;
    final controller = Get.find<ProductController>();
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 800;
    final horizontalPadding = size.width > 900
        ? size.width * 0.08
        : AppSizes.spacingXXLarge;
    final titleFontSize = size.width > 900
        ? AppSizes.fontMassive
        : AppSizes.fontXLarge;
    final labelFontSize = size.width > 900
        ? AppSizes.fontMedium
        : AppSizes.fontSmall;
    final contentFontSize = size.width > 900
        ? AppSizes.fontLarge
        : AppSizes.fontRegular;
    final detailSpacing = isWide
        ? AppSizes.spacingXXXLarge
        : AppSizes.spacingXXLarge;

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: GoogleFonts.montserrat(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: detailSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: GoogleFonts.montserrat(fontSize: labelFontSize),
                  ),
                  Text(
                    product.category,
                    style: GoogleFonts.montserrat(
                      fontSize: contentFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rating',
                  style: GoogleFonts.montserrat(fontSize: labelFontSize),
                ),
                Row(
                  children: [
                    Text(
                      '⭐',
                      style: GoogleFonts.montserrat(fontSize: labelFontSize),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rating} (${product.ratingCount})',
                      style: GoogleFonts.montserrat(fontSize: contentFontSize),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: detailSpacing),
        Text(
          'Price',
          style: GoogleFonts.montserrat(
            fontSize: labelFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '\$${product.price}',
          style: GoogleFonts.montserrat(
            fontSize: AppSizes.fontXXLarge,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: detailSpacing),

        ReadMoreText(
          product.description,
          trimMode: TrimMode.Line,
          trimLines: 3,
          trimCollapsedText: ' Show More',
          trimExpandedText: ' Show Less',
          style: GoogleFonts.montserrat(
            fontSize: contentFontSize,
            fontWeight: FontWeight.w500,
          ),
          moreStyle: GoogleFonts.montserrat(
            fontSize: contentFontSize,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          lessStyle: GoogleFonts.montserrat(
            fontSize: contentFontSize,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: detailSpacing),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.buttonVerticalPadding,
              ),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
              ),
            ),
            onPressed: () {
              controller.toggleFavorite(product.id);
              Get.snackbar(
                '',
                '',

                backgroundColor: AppColors.success,

                titleText: Text(
                  'Purchase Added',
                  style: GoogleFonts.montserrat(color: AppColors.white),
                ),
                messageText: Text(
                  'Successfully Purchase !',
                  style: GoogleFonts.montserrat(color: AppColors.white),
                ),
                duration: const Duration(milliseconds: 1500),
              );
              Future.delayed(const Duration(milliseconds: 3000), () {
                Get.back();
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_rounded,
                  color: AppColors.white,
                  size: 25,
                ),
                SizedBox(width: 10),
                Text(
                  'Purchase',
                  style: GoogleFonts.montserrat(
                    fontSize: AppSizes.fontRegular,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    final imageSection = Center(
      child: CachedNetworkImage(
        imageUrl: product.image,
        width: isWide ? size.width * 0.35 : size.width * 0.8,
        height: isWide ? 320 : 260,
        fit: BoxFit.contain,
        placeholder: (context, url) => const SizedBox(
          height: 48,
          width: 48,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: AlignmentGeometry.topLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  AppSizes.spacingXLarge,
                  horizontalPadding,
                  AppSizes.spacingXXLarge,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.topRight,
                      child: Obx(
                        () => IconButton(
                          icon: Icon(
                            controller.isFavorite(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.isFavorite(product.id)
                                ? AppColors.error
                                : null,
                            size: size.width > 900
                                ? AppSizes.iconLarge
                                : AppSizes.iconMedium,
                          ),
                          onPressed: () =>
                              controller.toggleFavorite(product.id),
                        ),
                      ),
                    ),
                    // SizedBox(height: AppSizes.spacingXXLarge),
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: imageSection),
                          const SizedBox(width: AppSizes.spacingXXXLarge),
                          Expanded(child: details),
                        ],
                      )
                    else ...[
                      imageSection,
                      SizedBox(height: AppSizes.spacingXLarge),
                      details,
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
