import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/errors/error_code.dart';
import '../../../core/errors/remote_excpetions.dart';
import '../../../core/models/enums/state_value.dart';
import '../data/restaurant_model.dart';
import '../data/restaurant_reopsitory.dart';
import 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepository restaurantRepository;

  RestaurantCubit({
    required this.restaurantRepository,
  }) : super(const RestaurantState());

  // GET LIST

  Future<void> getRestaurants() async {
    try {
      emit(
        state.copyWith(
          getState: StateValue.loading,
          getError: '',
        ),
      );

      final List<RestaurantModel> restaurants =
      await restaurantRepository.getRestaurants();

      emit(
        state.copyWith(
          getState: StateValue.loaded,
          restaurants: restaurants,
        ),
      );
    } on RemoteExceptions catch (e) {
      emit(
        state.copyWith(
          getState: StateValue.error,
          getError: e.errorMsg,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getState: StateValue.error,
          getError: ErrorCode.APP_ERROR.getLocalizedMessage(),
        ),
      );
    }
  }

  // GET BY ID

  Future<void> getRestaurant(String id) async {
    try {
      emit(
        state.copyWith(
          getByIdState: StateValue.loading,
          getByIdError: '',
        ),
      );

      final RestaurantModel? restaurant =
      await restaurantRepository.getRestaurant(id);

      emit(
        state.copyWith(
          getByIdState: StateValue.loaded,
          restaurant: restaurant,
        ),
      );
    } on RemoteExceptions catch (e) {
      emit(
        state.copyWith(
          getByIdState: StateValue.error,
          getByIdError: e.errorMsg,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getByIdState: StateValue.error,
          getByIdError:
          ErrorCode.APP_ERROR.getLocalizedMessage(),
        ),
      );
    }
  }

  // POST

  Future<void> createRestaurant(
      RestaurantModel restaurant,
      ) async {
    try {
      emit(
        state.copyWith(
          postState: StateValue.loading,
          postError: '',
        ),
      );

      await restaurantRepository.createRestaurant(
        restaurant,
      );

      emit(
        state.copyWith(
          postState: StateValue.loaded,
        ),
      );
    } on RemoteExceptions catch (e) {
      emit(
        state.copyWith(
          postState: StateValue.error,
          postError: e.errorMsg,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          postState: StateValue.error,
          postError:
          ErrorCode.APP_ERROR.getLocalizedMessage(),
        ),
      );
    }
  }

  // PUT

  Future<void> updateRestaurant(
      RestaurantModel restaurant,
      ) async {
    try {
      emit(
        state.copyWith(
          putState: StateValue.loading,
          putError: '',
        ),
      );

      await restaurantRepository.updateRestaurant(
        restaurant,
      );

      emit(
        state.copyWith(
          putState: StateValue.loaded,
        ),
      );
    } on RemoteExceptions catch (e) {
      emit(
        state.copyWith(
          putState: StateValue.error,
          putError: e.errorMsg,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          putState: StateValue.error,
          putError:
          ErrorCode.APP_ERROR.getLocalizedMessage(),
        ),
      );
    }
  }

  // DELETE

  Future<void> deleteRestaurant(String id) async {
    try {
      emit(
        state.copyWith(
          deleteState: StateValue.loading,
          deleteError: '',
        ),
      );

      await restaurantRepository.deleteRestaurant(id);

      emit(
        state.copyWith(
          deleteState: StateValue.loaded,
        ),
      );
    } on RemoteExceptions catch (e) {
      emit(
        state.copyWith(
          deleteState: StateValue.error,
          deleteError: e.errorMsg,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          deleteState: StateValue.error,
          deleteError:
          ErrorCode.APP_ERROR.getLocalizedMessage(),
        ),
      );
    }
  }
}