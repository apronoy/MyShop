import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_product/core/utils/app_colors.dart';

class App_bar extends StatelessWidget {
  const App_bar({
    super.key,
    required this.Title,
    this.icon,
    this.onTap,
    this.isback,
  });

  final String Title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool? isback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0.0, right: 8, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isback == true)
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Get.back();
                  },
                ),
              const SizedBox(width: 15),
              Text(
                Title,
                style: GoogleFonts.montserrat(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(icon, color: AppColors.textPrimary),

                onPressed: onTap,
              ),
            ),
        ],
      ),
    );
  }
}
