import '../../../models/brand.dart';
import '../../../models/category.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';

class ProductByCategoryProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  Category? mySelectedCategory;
  SubCategory? mySelectedSubCategory;
  List<SubCategory> subCategories = [];
  List<Brand> brands = [];
  List<Brand> selectedBrands = [];
  List<Product> filteredProduct = [];

  ProductByCategoryProvider(this._dataProvider);

  //TODO: should complete filterInitialProductAndSubCategory
  void filterInitialProductAndSubCategory(Category selectedCategory) {
    mySelectedSubCategory = SubCategory(name: 'All');
    mySelectedCategory = selectedCategory;
    subCategories = _dataProvider.subCategories
        .where((element) => element.categoryId?.sId == selectedCategory.sId)
        .toList();
    subCategories.insert(0, SubCategory(name: 'All'));
    filteredProduct = _dataProvider.products
        .where(
            (element) => element.proCategoryId?.name == selectedCategory.name)
        .toList();
    notifyListeners();
  }

  //TODO: should complete filterProductBySubCategory
  void filterProductBySubCategory(SubCategory subCategory) {
    mySelectedSubCategory = subCategory;
    selectedBrands = []; // reset brand filter when subcategory changes
    if (subCategory.name?.toLowerCase() == 'all') {
      filteredProduct = _dataProvider.products
          .where((element) =>
              element.proCategoryId?.name == mySelectedCategory?.name)
          .toList();
      brands = [];
    } else {
      filteredProduct = _dataProvider.products
          .where(
              (element) => element.proSubCategoryId?.name == subCategory.name)
          .toList();
      brands = _dataProvider.brands
          .where((element) => element.subcategoryId?.sId == subCategory.sId)
          .toList();
    }
    notifyListeners();
  }

  //TODO: should complete filterProductByBrand
  void filterProductByBrand() {
    final isAll = mySelectedSubCategory?.name?.toLowerCase() == 'all';
    if (selectedBrands.isEmpty) {
      // When no brand is selected, show all products for the current subcategory
      // If subcategory is 'All', fall back to filtering by category
      filteredProduct = _dataProvider.products
          .where((product) => isAll
              ? product.proCategoryId?.name == mySelectedCategory?.name
              : product.proSubCategoryId?.name == mySelectedSubCategory?.name)
          .toList();
    } else {
      filteredProduct = _dataProvider.products
          .where((product) =>
              (isAll
                  ? product.proCategoryId?.name == mySelectedCategory?.name
                  : product.proSubCategoryId?.name ==
                      mySelectedSubCategory?.name) &&
              selectedBrands
                  .any((brand) => product.proBrandId?.sId == brand.sId))
          .toList();
    }
    notifyListeners();
  }

  //TODO: should complete sortProducts
  void sortProducts(bool ascending) {
    filteredProduct.sort((a, b) {
      return ascending
          ? a.price!.compareTo(b.price!)
          : b.price!.compareTo(a.price!);
    });
    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }
}
