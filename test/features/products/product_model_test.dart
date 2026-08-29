import 'package:exercise_projects/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('ProductModel should convert JSON correctly', () {
    final json = {
      'id': 1,
      'name': 'iPhone',
      'price': 999,
    };

    final product = ProductModel.fromJson(json);

    expect(product.id, 1);
    expect(product.name, 'iPhone');
    expect(product.price, 999);
  });
}
