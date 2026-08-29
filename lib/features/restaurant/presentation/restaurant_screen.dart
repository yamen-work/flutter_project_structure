import 'package:exercise_projects/features/restaurant/data/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/enums/state_value.dart';
import '../bloc/restaurant_cubit.dart';
import '../bloc/restaurant_state.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<RestaurantCubit>().getRestaurants();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state.getState == StateValue.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.getState == StateValue.error) {
            return Center(
              child: Text(state.getError),
            );
          }

          if (state.restaurants.isEmpty) {
            return const Center(
              child: Text('No restaurants found'),
            );
          }

          return ListView.builder(
            itemCount: state.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = state.restaurants[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(restaurant.name),
                  subtitle: Text(
                    '${restaurant.location}\nRating: ${restaurant.rating}',
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'get') {
                        context
                            .read<RestaurantCubit>()
                            .getRestaurant(restaurant.id);
                      }

                      if (value == 'update') {
                        context
                            .read<RestaurantCubit>()
                            .updateRestaurant(
                          RestaurantModel(
                            id: restaurant.id,
                            location: restaurant.location,
                            name: '${restaurant.name} Updated',
                            rating: restaurant.rating,
                          ),
                        );
                      }

                      if (value == 'delete') {
                        context
                            .read<RestaurantCubit>()
                            .deleteRestaurant(
                          restaurant.id,
                        );
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'get',
                        child: Text('Get'),
                      ),
                      PopupMenuItem(
                        value: 'update',
                        child: Text('Update'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<RestaurantCubit>().createRestaurant(
            const RestaurantModel(
              id: '',
              location: 'Damascus',
              name: "Yamen's Food",
              rating: 5,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}