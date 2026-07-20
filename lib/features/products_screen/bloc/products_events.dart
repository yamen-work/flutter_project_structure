import 'package:exercise_projects/core/models/product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent{}

class CreateProduct extends ProductEvent{

  final Product product;

  CreateProduct({required this.product});

}

class UpdateProduct extends ProductEvent{

  final Product product;

  UpdateProduct({required this.product});

}

class DeleteProduct extends ProductEvent{

  final int productId;

  DeleteProduct({required this.productId});


}