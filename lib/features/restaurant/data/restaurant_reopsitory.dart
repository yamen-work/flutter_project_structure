
import 'package:exercise_projects/features/restaurant/data/remote_data_source.dart';
import 'package:exercise_projects/features/restaurant/data/restaurant_model.dart';

class RestaurantRepository {
  final RestaurantRemoteDataSource _dataSource;

  RestaurantRepository(this._dataSource);

  Future<List<RestaurantModel>> getRestaurants() {
    return _dataSource.getRestaurants();
  }

  Future<RestaurantModel?> getRestaurant(String id) {
    return _dataSource.getRestaurant(id);
  }

  Future<String> createRestaurant(
      RestaurantModel restaurant,
      ) {
    return _dataSource.createRestaurant(restaurant);
  }

  Future<void> updateRestaurant(
      RestaurantModel restaurant,
      ) {
    return _dataSource.updateRestaurant(restaurant);
  }

  Future<void> deleteRestaurant(String id) {
    return _dataSource.deleteRestaurant(id);
  }
}