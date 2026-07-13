import 'package:exercise_projects/core/models/drinks.dart';
import 'package:exercise_projects/features/home/bloc/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/enums/state_value.dart';
import '../../../core/models/coffee_beans_model.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {

  /// keep constructor looking like this
  HomeScreenCubit() : super(HomeScreenState());

  Future<void> getCoffeeBeansFromBackend() async {

    emit(state.copyWith(getCoffeeBeansState: StateValue.loading));

    try {
      /// here we should send the request to the backend
      await Future.delayed(Duration(seconds: 5));

      emit(
        state.copyWith(
          getCoffeeBeansState: StateValue.error,
          getCoffeeBeansErrorMessage: "لم نتمكن من الحصول على الحبوب"
        ),
      );
    } catch (error) {
      emit(state.copyWith(getCoffeeBeansState: StateValue.error,
          getCoffeeBeansErrorMessage: "فشل تحميل المنتجات"));
    }
  }

  Future<void> getDrinksFromBackend() async {
    emit(
      state.copyWith(
        getDrinksState: StateValue.loading,
      ),
    );

    try {
      await Future.delayed(const Duration(seconds: 3));

      emit(
        state.copyWith(
          getDrinksState: StateValue.loaded,
          drinks: [
            Drink(name: 'Latte', price: 4),
            Drink(name: 'Espresso', price: 3),
          ],
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          getDrinksState: StateValue.error,
          getDrinksErrorMessage: 'Failed to load drinks',
        ),
      );
    }
  }
}
