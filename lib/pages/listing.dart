import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';
import '../widgets/product_list.dart';
import '../widgets/search_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  void _onSearchSubmitted(String query) {
    BlocProvider.of<ProductBloc>(context).add(ProductSearching(query));
  }

  void _onClear() {
    _controller.clear();

    BlocProvider.of<ProductBloc>(context).add(ProductListing());
  }

  List<String> options = [];
  String dropdownValue = 'All Category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductCategoryLoaded) {
                options = [dropdownValue] + state.categories;
              }
            },
            child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
              if (state is ProductInitial) {
                return const CircularProgressIndicator();
              } else if (state is ProductListLoaded) {
                return Column(
                  children: [
                    SearchBar(
                      controller: _controller,
                      onSubmitted: _onSearchSubmitted,
                      onCleared: _onClear,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Select Category',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButton(
                              value: dropdownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: options.map<DropdownMenuItem<String>>(
                                  (String items) {
                                return DropdownMenuItem<String>(
                                  value: items,
                                  child: Text(
                                    items.toUpperCase(),
                                    style: dropdownValue == items
                                        ? const TextStyle(color: Colors.blue)
                                        : const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                                if (dropdownValue != "All Category") {
                                  BlocProvider.of<ProductBloc>(context).add(
                                      ProductCategorySearch(dropdownValue));
                                } else {
                                  BlocProvider.of<ProductBloc>(context)
                                      .add(ProductListing());
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ProductGridList(
                      state: state,
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
}
