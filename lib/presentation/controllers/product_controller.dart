import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_product/data/models/product_model.dart';
import 'package:my_product/data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository;

  ProductController(this.repository);

  var isLoading = true.obs;
  var isError = false.obs;

  var products = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  var favoriteIds = <int>[].obs;
  var favoriteProducts = <ProductModel>[].obs;
  List<ProductModel> get bannerProducts {
    // return products.take(5).toList();
    final List<ProductModel> banners = [];

    final catagories = [
      "men's clothing",
      "women's clothing",
      "electronics",
      "jewelery",
    ];

    for (final category in catagories) {
      try {
        banners.add(
          products.firstWhere(
            (product) => product.category.toLowerCase() == category,
          ),
        );
      } catch (_) {}
    }
    return banners;
  }

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      isError.value = false;

      products.value = await repository.getProducts();
      filteredProducts.value = products.toList();

      favoriteIds.value = await repository.getFavorites();
      favoriteProducts.value = products
          .where((product) => favoriteIds.contains(product.id))
          .toList();
    } on SocketException {
      isError.value = true;

      Get.snackbar(
        "No Internet",
        "Please check your internet connection.",
        backgroundColor: Colors.red,
      );
    } on TimeoutException {
      isError.value = true;

      Get.snackbar(
        "Timeout",
        "The server took too long to respond.",
        backgroundColor: Colors.orange,
      );
    } catch (e) {
      isError.value = true;

      Get.snackbar(
        "Warning",
        "Failed to load products. Please try again.",
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredProducts.value = products.toList();
      return;
    }

    filteredProducts.value = products.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<void> toggleFavorite(int productId) async {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }

    favoriteProducts.value = products
        .where((product) => favoriteIds.contains(product.id))
        .toList();

    await repository.saveFavorites(favoriteIds.toList());
  }

  bool isFavorite(int id) {
    return favoriteIds.contains(id);
  }
}
