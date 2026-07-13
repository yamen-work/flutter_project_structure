import 'package:equatable/equatable.dart';
import 'package:exercise_projects/core/models/coffee_beans_model.dart';
import 'package:exercise_projects/core/models/drinks.dart';
import '../../../core/models/enums/state_value.dart';

class HomeScreenState extends Equatable {

  /// where we control our state
  final StateValue getCoffeeBeansState;

  final String getCoffeeBeansErrorMessage;

  final List<CoffeeBeans> coffeeBeans;


  /// where we control our state
  final StateValue getDrinksState;

  final String getDrinksErrorMessage;

  final List<Drink> drinks;


  const HomeScreenState({

    this.getCoffeeBeansState = StateValue.init,
    this.getDrinksState = StateValue.init,

    this.getCoffeeBeansErrorMessage = '',
    this.getDrinksErrorMessage = '',

    this.coffeeBeans = const[],
    this.drinks = const []
  });

  HomeScreenState copyWith({
    StateValue? getCoffeeBeansState,
    String? getCoffeeBeansErrorMessage,
    List<CoffeeBeans>? coffeeBeans,
    StateValue? getDrinksState,
    String? getDrinksErrorMessage,
    List<Drink>? drinks,
  }) {
    return HomeScreenState(
      getCoffeeBeansState: getCoffeeBeansState ?? this.getCoffeeBeansState,
      getCoffeeBeansErrorMessage: getCoffeeBeansErrorMessage ??
          this.getCoffeeBeansErrorMessage,
      coffeeBeans: coffeeBeans ?? this.coffeeBeans,
      getDrinksState: getDrinksState ?? this.getDrinksState,
      getDrinksErrorMessage: getDrinksErrorMessage ??
          this.getDrinksErrorMessage,
      drinks: drinks ?? this.drinks,
    );
  }

  @override
  List<Object> get props =>
      [
        getCoffeeBeansState,
        getCoffeeBeansErrorMessage,
        coffeeBeans,
        getDrinksState,
        getDrinksErrorMessage,
        drinks,
      ];

}