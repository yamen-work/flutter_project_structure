import 'package:bloc_test/bloc_test.dart';
import 'package:exercise_projects/features/products/data/repositories/products_repository.dart';
import 'package:exercise_projects/features/products/presentation/cubit/products_cubit.dart';
import 'package:exercise_projects/features/products/presentation/cubit/products_state.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('ProductsCubit', () {
    test('initial state should be ProductsInitial', () {
      final cubit = ProductsCubit(
        ProductsRepository(),
      );

      expect(cubit.state, isA<ProductsInitial>());

      cubit.close();
    });

    blocTest<ProductsCubit, ProductsState>(
      'getProducts emits Loading then Success',
      build: () => ProductsCubit(
        ProductsRepository(),
      ),
      act: (cubit) => cubit.getProducts(),
      expect: () => [
        isA<ProductsLoading>(),
        isA<ProductsSuccess>(),
      ],
    );

    blocTest<ProductsCubit, ProductsState>(
      'getProducts returns 3 products',
      build: () => ProductsCubit(
        ProductsRepository(),
      ),
      act: (cubit) => cubit.getProducts(),
      verify: (cubit) {
        final state = cubit.state as ProductsSuccess;

        expect(state.products.length, 3);
        expect(state.products[0].name, 'iPhone');
        expect(state.products[1].name, 'MacBook');
        expect(state.products[2].name, 'AirPods');
      },
    );
  });
}
