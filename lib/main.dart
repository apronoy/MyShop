import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_product/injection.dart';
import 'package:my_product/core/utils/app_colors.dart';
import 'package:my_product/presentation/views/bottom_nabvar.dart';
import 'package:my_product/presentation/views/products/product_detail_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // Apply the centralized light theme
      theme: AppTheme.lightTheme,

      initialRoute: "/",

      getPages: [
        GetPage(name: "/", page: () => const BottomNavigationScreen()),

        GetPage(name: "/detail", page: () => const ProductDetailScreen()),
      ],
    );
  }
}
