import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_product/injection.dart';
import 'package:my_product/presentation/views/home_screen.dart';
import 'package:my_product/presentation/views/product_detail_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      debugShowCheckedModeBanner:
          false,

      initialRoute: "/",

      getPages: [

        GetPage(
          name: "/",
          page: () => HomeScreen(),
        ),

        GetPage(
          name: "/detail",
          page: () =>
              const ProductDetailScreen(),
        ),
      ],
    );
  }
}