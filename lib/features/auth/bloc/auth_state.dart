import 'package:equatable/equatable.dart';

import '../../../core/models/enums/state_value.dart';


class AuthState extends Equatable {
  final StateValue loginState;
  final StateValue registerState;
  final StateValue verifyState;
  final StateValue resendOTP;
  final StateValue resendPassword1;
  final StateValue resendPassword2;
  final String loginMessage;
  final String registerMessage;
  final String verifyMessage;
  final String resendPassword1Message;
  final String resendPassword2Message;
  final String resendOTPMessage;
  final StateValue logoutState;
  final String logoutMessage;
  final StateValue deleteAccount;
  final String deleteAccountMessage;
  final bool transferToVerifyScreen;
  final bool pendingApproval;
  final StateValue resendEmailForPassword;
  final String resendEmailForPasswordMessage;


  @override
  List<Object> get props =>
      [
        loginState,
        registerState,
        verifyState,
        resendOTP,
        resendPassword1,
        resendPassword2,
        loginMessage,
        registerMessage,
        verifyMessage,
        resendPassword1Message,
        resendPassword2Message,
        resendOTPMessage,
        logoutState,
        logoutMessage,
        deleteAccount,
        deleteAccountMessage,
        transferToVerifyScreen,
        pendingApproval,
        resendEmailForPassword,
        resendEmailForPasswordMessage,
      ];

  const AuthState({this.loginState = StateValue.init,
    this.registerState = StateValue.init,
    this.verifyState = StateValue.init,
    this.resendOTP = StateValue.init,
    this.resendPassword1 = StateValue.init,
    this.resendPassword2 = StateValue.init,
    this.logoutState = StateValue.init,
    this.deleteAccount = StateValue.init,
    this.resendEmailForPassword = StateValue.init,
    this.loginMessage = "",
    this.registerMessage = "",
    this.verifyMessage = "",
    this.resendOTPMessage = "",
    this.resendPassword1Message = "",
    this.resendPassword2Message = "",
    this.logoutMessage = "",
    this.deleteAccountMessage = "",
    this.resendEmailForPasswordMessage = "",
    this.transferToVerifyScreen = false,
    this.pendingApproval=false});

  AuthState copyWith({
    StateValue? loginState,
    StateValue? registerState,
    StateValue? verifyState,
    StateValue? resendOTP,
    StateValue? resendPassword1,
    StateValue? resendPassword2,
    String? loginMessage,
    String? registerMessage,
    String? verifyMessage,
    String? resendPassword1Message,
    String? resendPassword2Message,
    String? resendOTPMessage,
    StateValue? logoutState,
    String? logoutMessage,
    StateValue? deleteAccount,
    String? deleteAccountMessage,
    bool? transferToVerifyScreen,
    bool? pendingApproval,
    StateValue? resendEmailForPassword,
    String? resendEmailForPasswordMessage,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
      verifyState: verifyState ?? this.verifyState,
      resendOTP: resendOTP ?? this.resendOTP,
      resendPassword1: resendPassword1 ?? this.resendPassword1,
      resendPassword2: resendPassword2 ?? this.resendPassword2,
      loginMessage: loginMessage ?? this.loginMessage,
      registerMessage: registerMessage ?? this.registerMessage,
      verifyMessage: verifyMessage ?? this.verifyMessage,
      resendPassword1Message:
          resendPassword1Message ?? this.resendPassword1Message,
      resendPassword2Message:
          resendPassword2Message ?? this.resendPassword2Message,
      resendOTPMessage: resendOTPMessage ?? this.resendOTPMessage,
      logoutState: logoutState ?? this.logoutState,
      logoutMessage: logoutMessage ?? this.logoutMessage,
      deleteAccount: deleteAccount ?? this.deleteAccount,
      deleteAccountMessage: deleteAccountMessage ?? this.deleteAccountMessage,
      transferToVerifyScreen:
          transferToVerifyScreen ?? this.transferToVerifyScreen,
      pendingApproval: pendingApproval ?? this.pendingApproval,
      resendEmailForPassword:
          resendEmailForPassword ?? this.resendEmailForPassword,
      resendEmailForPasswordMessage:
          resendEmailForPasswordMessage ?? this.resendEmailForPasswordMessage,
    );
  }
}
