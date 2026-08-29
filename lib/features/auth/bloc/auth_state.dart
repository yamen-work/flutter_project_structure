import 'package:equatable/equatable.dart';

import '../../../core/models/enums/state_value.dart';

class AuthState extends Equatable {
  final StateValue loginState;
  final StateValue registerState;
  final StateValue forgotPasswordState;
  final StateValue logoutState;

  final String loginMessage;
  final String registerMessage;
  final String forgotPasswordMessage;
  final String logoutMessage;

  const AuthState({
    this.loginState = StateValue.init,
    this.registerState = StateValue.init,
    this.forgotPasswordState = StateValue.init,
    this.logoutState = StateValue.init,
    this.loginMessage = '',
    this.registerMessage = '',
    this.forgotPasswordMessage = '',
    this.logoutMessage = '',
  });

  AuthState copyWith({
    StateValue? loginState,
    StateValue? registerState,
    StateValue? forgotPasswordState,
    StateValue? logoutState,
    String? loginMessage,
    String? registerMessage,
    String? forgotPasswordMessage,
    String? logoutMessage,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
      forgotPasswordState:
          forgotPasswordState ?? this.forgotPasswordState,
      logoutState: logoutState ?? this.logoutState,
      loginMessage: loginMessage ?? this.loginMessage,
      registerMessage: registerMessage ?? this.registerMessage,
      forgotPasswordMessage:
          forgotPasswordMessage ?? this.forgotPasswordMessage,
      logoutMessage: logoutMessage ?? this.logoutMessage,
    );
  }

  @override
  List<Object> get props => [
        loginState,
        registerState,
        forgotPasswordState,
        logoutState,
        loginMessage,
        registerMessage,
        forgotPasswordMessage,
        logoutMessage,
      ];
}