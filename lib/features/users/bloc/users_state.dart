import 'package:equatable/equatable.dart';

import '../../../core/models/enums/state_value.dart';
import '../domain/user_entity.dart';

class UsersState extends Equatable {
  final StateValue getState;
  final List<UserEntity> users;
  final String getError;

  const UsersState({
    this.getState = StateValue.init,
    this.users = const [],
    this.getError = '',
  });

  UsersState copyWith({
    StateValue? getState,
    List<UserEntity>? users,
    String? getError,
  }) {
    return UsersState(
      getState: getState ?? this.getState,
      users: users ?? this.users,
      getError: getError ?? this.getError,
    );
  }

  @override
  List<Object?> get props => [
        getState,
        users,
        getError,
      ];
}