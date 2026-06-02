import '../../data/datasources/localData.dart';
import '../../data/datasources/apiData.dart';
import '../../data/repositories/product_repo_service.dart';
import '../controllers/product_controller.dart';

class HomeBinding {
  static ProductController bind() {
    final remoteDataSource = ApiData();
    final localDataSource = LocalData();
    final repository = ProductRepoService(remoteDataSource, localDataSource);

    return ProductController(repository);
  }
}
