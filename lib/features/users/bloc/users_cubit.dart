import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_code.dart';
import '../../../core/errors/remote_excpetions.dart';
import '../../../core/models/enums/state_value.dart';
import '../domain/use_cases/get_users_use_case.dart';
import '../domain/user_entity.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {

  final GetUsersUseCase getUsersUseCase;

  UsersCubit({
    required this.getUsersUseCase,
  }) : super(const UsersState());

  Future<void> getUsers() async {
    try {
      emit(
        state.copyWith(
          getState: StateValue.loading,
          getError: '',
        ),
      );

      final List<UserEntity> users = await getUsersUseCase();

      emit(
        state.copyWith(
          getState: StateValue.loaded,
          users: users,
        ),
      );
    }on RemoteExceptions catch (e) {
      emit(
        state.copyWith(
          getState: StateValue.error,
          getError: e.errorMsg
        ),
      );
      
    } catch (e) {
      emit(
        state.copyWith(
          getState: StateValue.error,
          getError: ErrorCode.APP_ERROR.getLocalizedMessage(),
        ),
      );
    }
  }
}