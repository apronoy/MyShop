import 'package:my_product/data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<List<int>> getFavorites();
  Future<void> saveFavorites(List<int> products);
}
