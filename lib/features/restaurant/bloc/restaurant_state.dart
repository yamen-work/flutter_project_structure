import 'package:equatable/equatable.dart';
import '../../../core/models/enums/state_value.dart';
import '../data/restaurant_model.dart';

class RestaurantState extends Equatable {
  final StateValue getState;
  final StateValue getByIdState;
  final StateValue postState;
  final StateValue putState;
  final StateValue deleteState;

  final List<RestaurantModel> restaurants;
  final RestaurantModel? restaurant;

  final String getError;
  final String getByIdError;
  final String postError;
  final String putError;
  final String deleteError;

  const RestaurantState({
    this.getState = StateValue.init,
    this.getByIdState = StateValue.init,
    this.postState = StateValue.init,
    this.putState = StateValue.init,
    this.deleteState = StateValue.init,
    this.restaurants = const [],
    this.restaurant,
    this.getError = '',
    this.getByIdError = '',
    this.postError = '',
    this.putError = '',
    this.deleteError = '',
  });

  RestaurantState copyWith({
    StateValue? getState,
    StateValue? getByIdState,
    StateValue? postState,
    StateValue? putState,
    StateValue? deleteState,
    List<RestaurantModel>? restaurants,
    RestaurantModel? restaurant,
    String? getError,
    String? getByIdError,
    String? postError,
    String? putError,
    String? deleteError,
  }) {
    return RestaurantState(
      getState: getState ?? this.getState,
      getByIdState: getByIdState ?? this.getByIdState,
      postState: postState ?? this.postState,
      putState: putState ?? this.putState,
      deleteState: deleteState ?? this.deleteState,
      restaurants: restaurants ?? this.restaurants,
      restaurant: restaurant ?? this.restaurant,
      getError: getError ?? this.getError,
      getByIdError: getByIdError ?? this.getByIdError,
      postError: postError ?? this.postError,
      putError: putError ?? this.putError,
      deleteError: deleteError ?? this.deleteError,
    );
  }

  @override
  List<Object?> get props => [
    getState,
    getByIdState,
    postState,
    putState,
    deleteState,
    restaurants,
    restaurant,
    getError,
    getByIdError,
    postError,
    putError,
    deleteError,
  ];
}