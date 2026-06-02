import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:my_product/data/datasources/localData.dart';
import 'package:my_product/data/datasources/apiData.dart';
import 'package:my_product/data/repositories/product_repo_service.dart';
import 'package:my_product/data/repositories/product_repository.dart';
import 'package:my_product/presentation/controllers/product_controller.dart';

void initDependencies() {
  Get.lazyPut(() => ApiData());

  Get.lazyPut(() => LocalData());

  Get.lazyPut<ProductRepository>(
    () => ProductRepoService(Get.find(), Get.find()),
  );

  Get.lazyPut(() => ProductController(Get.find()));
}
