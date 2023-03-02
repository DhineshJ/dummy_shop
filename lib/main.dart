import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dummy_shop/bloc/product/product_bloc.dart';
import 'package:dummy_shop/pages/listing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterJ Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ListPage());
  }
}

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (context) => ProductBloc()
          ..add(ProductListing())
          ..add(ProductCategoryListing()),
        child: const MyHomePage(title: 'Product List'),
      ),
    );
  }
}
