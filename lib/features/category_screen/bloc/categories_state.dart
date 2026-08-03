import '../../../core/models/category.dart';
import '../../../core/models/enums/state_value.dart';

class CategoriesState {

  final StateValue getState;
  final StateValue postState;
  final StateValue putState;
  final StateValue deleteState;

  final List<Category> topics;

  final String? getError;
  final String? postError;
  final String? putError;
  final String? deleteError;

  const CategoriesState({
    this.getState = StateValue.init,
    this.postState = StateValue.init,
    this.putState = StateValue.init,
    this.deleteState = StateValue.init,
    this.topics = const [],
    this.getError,
    this.postError,
    this.putError,
    this.deleteError,
  });

  CategoriesState copyWith({
    StateValue? getState,
    StateValue? postState,
    StateValue? putState,
    StateValue? deleteState,
    List<Category>? topics,
    String? getError,
    String? postError,
    String? putError,
    String? deleteError,
  }) {
    return CategoriesState(
      getState: getState ?? this.getState,
      postState: postState ?? this.postState,
      putState: putState ?? this.putState,
      deleteState: deleteState ?? this.deleteState,
      topics: topics ?? this.topics,
      getError: getError ?? this.getError,
      postError: postError ?? this.postError,
      putError: putError ?? this.putError,
      deleteError: deleteError ?? this.deleteError,
    );
  }
}