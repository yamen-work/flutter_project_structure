import '../models/product_model.dart';

class ProductsRepository {
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ProductModel(
        id: 1,
        name: 'iPhone',
        price: 999,
      ),
      ProductModel(
        id: 2,
        name: 'MacBook',
        price: 1999,
      ),
      ProductModel(
        id: 3,
        name: 'AirPods',
        price: 199,
      ),
    ];
  }
}
