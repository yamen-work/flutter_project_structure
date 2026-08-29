import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_code.dart';
import '../../../core/errors/remote_excpetions.dart';
import '../../../core/models/enums/state_value.dart';
import '../../../core/services/firebase/firebase_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseService _firebaseService;

  AuthCubit({required FirebaseService firebaseService})
    : _firebaseService = firebaseService,
      super(const AuthState());

  //  LOGIN

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loginState: StateValue.loading));

    try {
      await _firebaseService.login(email: email, password: password);

      emit(state.copyWith(loginState: StateValue.loaded, loginMessage: 'success'), );
    } catch (e) {
      if (e is RemoteExceptions) {
        emit(
          state.copyWith(
            loginState: StateValue.error,
            loginMessage: e.errorMsg.toString(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            loginState: StateValue.error,
            loginMessage: ErrorCode.APP_ERROR.getLocalizedMessage(),
          ),
        );
      }
    }
  }

  //  REGISTER

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required int age,
  }) async {
    emit(state.copyWith(registerState: StateValue.loading));

    try {
      await _firebaseService.register(
        name: name,
        email: email,
        password: password,
        age: age,
      );

      emit(
        state.copyWith(
          registerState: StateValue.loaded,
          registerMessage: 'success',
        ),
      );
    } catch (e) {
      if (e is RemoteExceptions) {
        emit(
          state.copyWith(
            registerState: StateValue.error,
            registerMessage: e.errorMsg.toString(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            registerState: StateValue.error,
            registerMessage: ErrorCode.APP_ERROR.getLocalizedMessage(),
          ),
        );
      }
    }
  }

  //  FORGOT PASSWORD

  Future<void> forgotPassword(String email) async {
    emit(state.copyWith(forgotPasswordState: StateValue.loading));

    try {
      await _firebaseService.forgotPassword(email: email);

      emit(
        state.copyWith(
          forgotPasswordState: StateValue.loaded,
          forgotPasswordMessage: 'check your email',
        ),
      );
    } catch (e) {
      if (e is RemoteExceptions) {
        emit(
          state.copyWith(
            forgotPasswordState: StateValue.error,
            forgotPasswordMessage: e.errorMsg.toString(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            forgotPasswordState: StateValue.error,
            forgotPasswordMessage: ErrorCode.APP_ERROR.getLocalizedMessage(),
          ),
        );
      }
    }
  }

  //  LOGOUT

  Future<void> logout() async {
    emit(state.copyWith(logoutState: StateValue.loading));

    try {
      await _firebaseService.logout();

      emit(
        state.copyWith(
          logoutState: StateValue.loaded,
          logoutMessage: 'success',
        ),
      );
    } catch (e) {
      if (e is RemoteExceptions) {
        emit(
          state.copyWith(
            logoutState: StateValue.error,
            logoutMessage: e.errorMsg.toString(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            logoutState: StateValue.error,
            logoutMessage: ErrorCode.APP_ERROR.getLocalizedMessage(),
          ),
        );
      }
    }
  }
}
