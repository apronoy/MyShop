import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';
import 'package:my_product/presentation/views/cart/cart_page.dart';
import 'package:my_product/presentation/views/profile/profile.dart';

import '../views/products/all_product.dart';
import '../views/home/home_screen.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final controller = Get.find<ProductController>();

  final RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> screens = [
    HomeScreen(),
    CartPage(allproduct: Get.find<ProductController>()),
    ProductSection(),
    const ProfilePage(),
  ];
}
