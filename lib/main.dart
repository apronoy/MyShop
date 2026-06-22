import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_product/injection.dart';
import 'package:my_product/core/utils/app_colors.dart';
import 'package:my_product/presentation/views/bottom_nabvar.dart';
import 'package:my_product/presentation/views/products/product_cart_details.dart';
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
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      ),

      initialRoute: "/",

      getPages: [
        GetPage(name: "/", page: () => const BottomNavigationScreen()),

        GetPage(name: "/detail", page: () => const ProductDetailScreen()),
        GetPage(name: "/Cartdetail", page: () => const ProductCartDetails()),
      ],
    );
  }
}
