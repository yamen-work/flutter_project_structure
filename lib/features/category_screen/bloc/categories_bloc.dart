import 'package:dio/dio.dart';
import 'package:exercise_projects/features/category_screen/bloc/categories_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/category.dart';
import '../../../core/models/enums/state_value.dart';
import '../../../core/services/remote_api_service.dart';

class CategoriesCubit extends Cubit<CategoriesState> {

  final RemoteApiService service;

  CategoriesCubit({required this.service}) : super(const CategoriesState());

  Future<void> getTopics() async {
    try {

      emit(state.copyWith(getState: StateValue.loading));

      final  Response response = await service.getRequest("/topics/");

      List<Category> categories =

      (response.data  ["data"] as List)   .map(    (index) =>  Category.fromJson(index)   ).toList();

      emit(state.copyWith(getState: StateValue.loaded, topics: categories));

    } catch (e) {
      emit(state.copyWith(getState: StateValue.error, getError: e.toString()));
    }
  }



  Future addTopic (Category category)
  async{
    emit(state.copyWith(postState: StateValue.loading));

    try{
      Response response = await service.postRequest("/topics/", category.toJson());
      emit(state.copyWith(postState: StateValue.loaded));
      getTopics();
    }
    catch(e)
    {
      emit(state.copyWith(postState: StateValue.error,postError: e.toString()));
    }

  }


  Future editTopic (Category category)
  async{
    emit(state.copyWith(putState: StateValue.loading));
    try{
      Response response = await service.putRequest("/topics/${category.id}/", category.toJson());
      emit(state.copyWith(putState: StateValue.loaded));
      getTopics();
    }
    catch(e)
    {
      emit(state.copyWith(putState: StateValue.error,putError: e.toString()));
    }

  }


  Future deleteTopic (Category category)
  async{
    emit(state.copyWith(deleteState: StateValue.loading));
    try{
      Response response = await service.deleteRequest("/topics",category.id.toString());
      emit(state.copyWith(deleteState: StateValue.loaded));
      getTopics();
    }
    catch(e)
    {
      emit(state.copyWith(deleteState: StateValue.error,deleteError: e.toString()));
    }

  }
}
