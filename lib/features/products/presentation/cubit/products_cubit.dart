import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/products_repository.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository repository;

  ProductsCubit(this.repository) : super(ProductsInitial());

  Future<void> getProducts() async {
    emit(ProductsLoading());

    try {
      final products = await repository.getProducts();

      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
