import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/product.dart';
import '../../bloc/products_bloc.dart';
import '../../bloc/products_events.dart';
import '../../bloc/products_state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).add(LoadProducts());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Products Screen", style: TextStyle(color: Colors.white)),
      ),

      body: BlocBuilder<ProductsBloc, ProductState>(
        builder: (context, state) {

          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text("No Products"));
            }

            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text("\$${product.price}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            context.read<ProductsBloc>().add(
                              UpdateProduct(
                                product: Product(
                                  id: product.id,
                                  name: "${product.name} Updated",
                                  price: product.price + 100,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<ProductsBloc>().add(
                              DeleteProduct(productId: product.id),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          else
            {
              return const Center(child: CircularProgressIndicator());
            }


        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProductsBloc>().add(
            CreateProduct(
              product: Product(
                id: DateTime.now().millisecondsSinceEpoch,
                name: "Product ${DateTime.now().second}",
                price: 100,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
