import 'package:exercise_projects/features/products_screen/bloc/products_events.dart';
import 'package:exercise_projects/features/products_screen/bloc/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/product.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductState> {
  final List<Product> _products = [

    Product(
      id: 1,
      name: "iPhone 16 Pro",
      price: 1199,
    ),
    Product(
      id: 2,
      name: "Samsung Galaxy S25",
      price: 999,
    ),
    Product(
      id: 3,
      name: "Google Pixel 10",
      price: 899,
    ),
    Product(
      id: 4,
      name: "MacBook Air M4",
      price: 1399,
    ),
    Product(
      id: 5,
      name: "iPad Air",
      price: 699,
    ),
    Product(
      id: 6,
      name: "Sony WH-1000XM6",
      price: 399,
    ),
    Product(
      id: 7,
      name: "Apple Watch Series 11",
      price: 499,
    ),
    Product(
      id: 8,
      name: "Nintendo Switch 2",
      price: 449,
    ),

  ];

  ProductsBloc() : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      await Future.delayed(Duration(seconds: 3));
      emit(ProductLoaded(_products));
    });

    on<CreateProduct>((event, emit) {
      _products.add(event.product);
      emit(ProductLoaded(_products));
    });

    on<UpdateProduct>((event, emit) {
      final index = _products.indexWhere(
        (product) => product.id == event.product.id,
      );
      if (index != -1) {
        _products[index] = event.product;
        emit(ProductLoaded(List.from(_products)));
      }
    });

    on<DeleteProduct>((event, emit) {
      _products.removeWhere((product) => product.id == event.productId);
      emit(ProductLoaded(List.from(_products)));
    });
  }
}
