import 'package:dio/dio.dart';
import 'package:exercise_projects/core/errors/error_code.dart';
import 'package:exercise_projects/core/errors/remote_excpetions.dart';
import 'package:exercise_projects/core/models/review_model.dart';
import 'package:exercise_projects/features/review_screen/bloc/review_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/category.dart';
import '../../../core/models/enums/state_value.dart';
import '../../../core/services/remote_api_service.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final RemoteApiService service;

  ReviewsCubit({required this.service}) : super(const ReviewsState());

  Future<void> getReviews() async {
    try {
      emit(state.copyWith(getState: StateValue.loading));

      final Response response = await service.getRequest("/feedbacks/");

      List<ReviewModel> reviews = (response.data["info"] as List)
          .map((index) => ReviewModel.fromJson(index))
          .toList();

      emit(state.copyWith(getState: StateValue.loaded, reviews: reviews));
    } on RemoteExceptions catch (e) {
      emit(state.copyWith(getState: StateValue.error, getError: e.errorMsg));
    } catch (e) {
      emit(
        state.copyWith(
          getState: StateValue.error,
          getError: ErrorCode.APP_ERROR.getLocalizedMessage(),
        ),
      );
    }
  }

  Future<void> addReview(ReviewModel review) async {
    try {
      emit(state.copyWith(postState: StateValue.loading, postError: null));

      await service.postFormData("/feedbacks/store/", await review.toJson());

      emit(state.copyWith(postState: StateValue.loaded));

      await getReviews();
    } catch (e) {
      emit(
        state.copyWith(postState: StateValue.error, postError: e.toString()),
      );
    }
  }

  Future<void> updateReview(ReviewModel review) async {
    try {
      emit(state.copyWith(putState: StateValue.loading, putError: null));

      await service.putFormData(
        "/feedbacks/update/${review.id}/",
        await review.toJson(),
      );

      emit(state.copyWith(putState: StateValue.loaded));

      await getReviews();
    } catch (e) {
      emit(state.copyWith(putState: StateValue.error, putError: e.toString()));
    }
  }

  Future<void> deleteReview(int id) async {
    debugPrint("id : " + id.toString());
    try {
      emit(state.copyWith(deleteState: StateValue.loading, deleteError: null));

      await service.deleteRequest("/feedbacks/delete", id.toString());

      emit(state.copyWith(deleteState: StateValue.loaded));

      await getReviews();
    } catch (e) {
      emit(
        state.copyWith(
          deleteState: StateValue.error,
          deleteError: e.toString(),
        ),
      );
    }
  }
}
