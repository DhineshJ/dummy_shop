import 'package:flutter/material.dart';

import '../bloc/product/product_bloc.dart';

class ProductGridList extends StatelessWidget {
  const ProductGridList({
    super.key,
    required this.state,
  });
  final ProductListLoaded state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 300),
          itemBuilder: (context, index) {
            return Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(state
                                    .productResult.products[index].thumbnail),
                                fit: BoxFit.fill)),
                        // child: Image.network(),
                      ),
                      Text(
                        state.productResult.products[index].title,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        state.productResult.products[index].description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$ ${state.productResult.products[index].price.toString()}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            );
          },
          itemCount: state.productResult.limit),
    );
  }
}
