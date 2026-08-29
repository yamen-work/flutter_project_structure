
import 'package:exercise_projects/features/restaurant/data/restaurant_model.dart';

import '../../../core/services/firebase/firebase_service.dart';

class RestaurantRemoteDataSource {
  final FirebaseService _firebaseService;

  RestaurantRemoteDataSource(this._firebaseService);

  static const String _collection = 'restaurants';

  Future<List<RestaurantModel>> getRestaurants() async {
    final response = await _firebaseService.getList(
      _collection,
    );

    return response
        .map(RestaurantModel.fromJson)
        .toList();
  }

  Future<RestaurantModel?> getRestaurant(String id) async {
    final response = await _firebaseService.getDocument(
      _collection,
      id,
    );

    if (response == null) {
      return null;
    }

    return RestaurantModel.fromJson(response);
  }

  Future<String> createRestaurant(
      RestaurantModel restaurant,
      ) {
    return _firebaseService.post(
      _collection,
      restaurant.toJson(),
    );
  }

  Future<void> updateRestaurant(
      RestaurantModel restaurant,
      ) {
    return _firebaseService.put(
      _collection,
      restaurant.id,
      restaurant.toJson(),
    );
  }

  Future<void> deleteRestaurant(String id) {
    return _firebaseService.delete(
      _collection,
      id,
    );
  }
}