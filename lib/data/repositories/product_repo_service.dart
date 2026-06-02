import 'package:my_product/data/datasources/localData.dart';
import 'package:my_product/data/datasources/apiData.dart';
import 'package:my_product/data/models/product_model.dart';
import 'package:my_product/data/repositories/product_repository.dart';

class ProductRepoService implements ProductRepository {
  final ApiData remote;
  final LocalData local;

  ProductRepoService(this.remote, this.local);

  @override
  Future<List<ProductModel>> getProducts() {
    return remote.getProducts();
  }

  @override
  Future<List<int>> getFavorites() {
    return local.getFavorites();
  }

  @override
  Future<void> saveFavorites(List<int> ids) {
    return local.saveFavorites(ids);
  }
}
