import 'package:equatable/equatable.dart';
import 'package:exercise_projects/core/models/review_model.dart';

import '../../../core/models/category.dart';
import '../../../core/models/enums/state_value.dart';

class ReviewsState extends Equatable {

  final StateValue getState;
  final StateValue postState;
  final StateValue putState;
  final StateValue deleteState;

  final List<ReviewModel> reviews;

  final String? getError;
  final String? postError;
  final String? putError;
  final String? deleteError;

  const ReviewsState({
    this.getState = StateValue.init,
    this.postState = StateValue.init,
    this.putState = StateValue.init,
    this.deleteState = StateValue.init,
    this.reviews = const [],
    this.getError,
    this.postError,
    this.putError,
    this.deleteError,
  });

  ReviewsState copyWith({
    StateValue? getState,
    StateValue? postState,
    StateValue? putState,
    StateValue? deleteState,
    List<ReviewModel>? reviews,
    String? getError,
    String? postError,
    String? putError,
    String? deleteError,
  }) {
    return ReviewsState(
      getState: getState ?? this.getState,
      postState: postState ?? this.postState,
      putState: putState ?? this.putState,
      deleteState: deleteState ?? this.deleteState,
      reviews: reviews ?? this.reviews,
      getError: getError ?? this.getError,
      postError: postError ?? this.postError,
      putError: putError ?? this.putError,
      deleteError: deleteError ?? this.deleteError,
    );
  }


  @override
  List<Object?> get props =>
      [
        getState,
        postState,
        putState,
        deleteState,
        reviews,
        getError,
        postError,
        putError,
        deleteError,
      ];

}