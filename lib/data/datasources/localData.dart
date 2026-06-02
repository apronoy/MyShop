import 'package:shared_preferences/shared_preferences.dart';
class LocalData {
  static const String favoriteKey = 'favorites';

  Future<List<int>> getFavorites() async {
    final storedData = await SharedPreferences.getInstance();

    final fevoList = storedData.getStringList(favoriteKey) ?? [];

    return fevoList.map(int.parse).toList();
  }

  Future<void> saveFavorites(List<int> products) async {
    final storedData = await SharedPreferences.getInstance();

    await storedData.setStringList(
      favoriteKey,
      products.map((e) => e.toString()).toList(),
    );
  }
}
