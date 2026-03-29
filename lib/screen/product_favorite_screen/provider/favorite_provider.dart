import 'package:e_commerce_flutter/utility/constants.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  final box = GetStorage();
  List<Product> favoriteProduct = [];
  FavoriteProvider(this._dataProvider) {
    loadFavoriteItems();
  }

  //? Method to update the favorite list (add or remove)
  void updateToFavoriteList(String productId) {
    List<dynamic> storedIds = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    List<String> favoriteIds = storedIds.cast<String>();
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }
    box.write(FAVORITE_PRODUCT_BOX, favoriteIds);
    loadFavoriteItems();
  }

  //? Method to check if a product is in the favorite list
  bool checkIsItemFavorite(String productId) {
    List<dynamic> storedIds = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    List<String> favoriteIds = storedIds.cast<String>();
    return favoriteIds.contains(productId);
  }

  //? Method to load favorite items from storage and match with products from DataProvider
  void loadFavoriteItems() {
    List<dynamic> storedIds = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    List<String> favoriteIds = storedIds.cast<String>();
    favoriteProduct = _dataProvider.allProducts
        .where((product) => favoriteIds.contains(product.sId))
        .toList();
    notifyListeners();
  }

  //? Method to clear the favorite list
  void clearFavoriteList() {
    box.remove(FAVORITE_PRODUCT_BOX);
    favoriteProduct = [];
    notifyListeners();
  }
}
