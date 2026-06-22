import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_product/core/utils/app_colors.dart';
import 'package:my_product/presentation/controllers/bottom_navigation_controler.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // with getx Navigation bar  ....

    final controler = Get.put(NavigationController());

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => IndexedStack(
              index: controler.selectedIndex.value,
              children: controler.screens,
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: SafeArea(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                      ),
                      child: BottomNavigationBar(
                        backgroundColor: Colors.transparent,
                        elevation: 20,
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: AppColors.primary,
                        unselectedItemColor: Colors.white,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        selectedFontSize: 0,
                        unselectedFontSize: 0,
                        iconSize: 25,
                        selectedIconTheme: const IconThemeData(size: 34),
                        currentIndex: controler.selectedIndex.value,
                        onTap: controler.changeIndex,
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.shopping_cart_rounded),
                            label: 'Cart',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.grid_view_rounded),
                            label: 'Products',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person_2_rounded),
                            label: 'Profile',
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
