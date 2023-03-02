import 'dart:convert';

 
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import 'package:http/http.dart' as http;

import '../../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductListing>((event, emit) async {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      final finalResult = ProductResult.fromJson(json.decode(response.body));
      emit(ProductListLoaded(finalResult));
    });

    on<ProductSearching>((event, emit) async {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/products/search?q=${event.searchText}'));

      final finalResult = ProductResult.fromJson(json.decode(response.body));
      emit(ProductListLoaded(finalResult));
    });
    on<ProductCategoryListing>((event, emit) async {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/products/categories'));

      // final finalResult = ProductResult.fromJson(json.decode(response.body));
      emit(ProductCategoryLoaded(
          List<String>.from(json.decode(response.body).map((x) => x))));
    });
    on<ProductCategorySearch>((event, emit) async {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/products/category/${event.searchCategory}'));

      final finalResult = ProductResult.fromJson(json.decode(response.body));
      emit(ProductListLoaded(finalResult));
    });
  }

  
}
