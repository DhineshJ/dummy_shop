part of 'product_bloc.dart';

 
abstract class ProductState extends Equatable {}

class ProductInitial extends ProductState {
  @override
 
  List<Object?> get props => [];
}

class ProductListLoaded extends ProductState {
  final ProductResult productResult;

  ProductListLoaded(this.productResult);

  @override
  List<Object?> get props => [productResult];
}

class ProductCategoryLoaded extends ProductState {
  final List<String> categories;

  ProductCategoryLoaded(this.categories);
  @override
  List<Object?> get props => [];
}

 