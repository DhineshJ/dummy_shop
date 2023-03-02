part of 'product_bloc.dart';

 
abstract class ProductEvent {}

class ProductListing extends ProductEvent {}

class ProductCategoryListing extends ProductEvent {}

class ProductCategorySearch extends ProductEvent {
  final String searchCategory;

  ProductCategorySearch(this.searchCategory);
  
}

class ProductSearching extends ProductEvent {
  final String searchText;

  ProductSearching(this.searchText);
}
