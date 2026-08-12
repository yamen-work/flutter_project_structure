import 'package:exercise_projects/core/errors/error_code.dart';
import 'package:exercise_projects/features/auth/data/auth_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/remote_excpetions.dart';
import '../../../core/models/enums/state_value.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final AuthRemoteDataSource _remoteDatasource;

  AuthCubit({required AuthRemoteDataSource remoteDatasource})
      : _remoteDatasource = remoteDatasource,
        super(const AuthState());

  Future<void> login(String email, String password) async {

    emit(state.copyWith(loginState: StateValue.loading));

    try {

      await _remoteDatasource.login(email: email, password: password);

      emit(state.copyWith(loginState: StateValue.loaded, loginMessage: "success"));


    } catch (e) {
      if (e is RemoteExceptions) {

        emit(state.copyWith(loginState: StateValue.error, loginMessage: e.errorMsg.toString(), pendingApproval: true));

      } else {

        emit(state.copyWith(loginState: StateValue.error, loginMessage: ErrorCode.APP_ERROR.getLocalizedMessage()));
      }
    }
  }

  // Future<void> register({required String name, required String address, required String password, required String phone}) async
  // {
  //
  //   emit(state.copyWith(registerState: StateValue.loading));
  //
  //   Map<String, dynamic> payload = {
  //     'name': name,
  //     'address': address,
  //     'phone': phone,
  //     'password': password,
  //     'password_confirmation': password,
  //
  //
  //   };
  //
  //   try {
  //     await _remoteDatasource.performPostRequest("registerUser", payload, (map) {}, useToken: false);
  //
  //     emit(state.copyWith(registerState: StateValue.loaded, registerMessage: "success"));
  //
  //
  //   } catch (e) {
  //
  //     if (e is RemoteExceptions) {
  //
  //       emit(state.copyWith(registerState: StateValue.error, registerMessage: e.errorMsg.toString(), transferToVerifyScreen: false));
  //
  //     } else {
  //
  //       emit(state.copyWith(registerState: StateValue.error, registerMessage: e.toString(), transferToVerifyScreen: false));
  //     }
  //   }
  // }



  // Future<void> logout() async {
  //   emit(state.copyWith(logoutState: StateValue.loading));
  //   try {
  //
  //     await _remoteDatasource.performLogoutRequest("logout", useToken: true);
  //
  //     emit(state.copyWith(logoutState: StateValue.loaded, logoutMessage: "عد مجدداً"));
  //   } catch (e) {
  //     if (e is RemoteExceptions) {
  //
  //       emit(state.copyWith(logoutState: StateValue.error, logoutMessage: e.errorCode.getLocalizedMessage()));
  //
  //     } else {
  //       emit(state.copyWith(logoutState: StateValue.error, logoutMessage: e.toString()));
  //     }
  //   }
  // }






}
