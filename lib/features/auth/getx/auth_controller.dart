import 'package:get/get.dart';
import '../../../core/errors/error_code.dart';
import '../../../core/errors/remote_excpetions.dart';
import '../../../core/models/enums/state_value.dart';
import '../../../core/services/firebase/firebase_service.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService;

  AuthController({
    required FirebaseService firebaseService,
  }) : _firebaseService = firebaseService;

  // ===================== LOGIN =====================

  final Rx<StateValue> loginState = StateValue.init.obs;
  final RxString loginMessage = ''.obs;

  Future<void> login(
    String email,
    String password,
  ) async {
    loginState.value = StateValue.loading;

    try {
      await _firebaseService.login(
        email: email,
        password: password,
      );

      loginState.value = StateValue.loaded;
      loginMessage.value = 'success';
    } catch (e) {
      loginState.value = StateValue.error;

      if (e is RemoteExceptions) {
        loginMessage.value = e.errorMsg.toString();
      } else {
        loginMessage.value =
            ErrorCode.APP_ERROR.getLocalizedMessage();
      }
    }
  }

  // ===================== REGISTER =====================

  final Rx<StateValue> registerState = StateValue.init.obs;
  final RxString registerMessage = ''.obs;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required int age,
  }) async {
    registerState.value = StateValue.loading;

    try {
      await _firebaseService.register(
        name: name,
        email: email,
        password: password,
        age: age,
      );

      registerState.value = StateValue.loaded;
      registerMessage.value = 'success';
    } catch (e) {
      registerState.value = StateValue.error;

      if (e is RemoteExceptions) {
        registerMessage.value = e.errorMsg.toString();
      } else {
        registerMessage.value =
            ErrorCode.APP_ERROR.getLocalizedMessage();
      }
    }
  }

  // ===================== FORGOT PASSWORD =====================

  final Rx<StateValue> forgotPasswordState = StateValue.init.obs;
  final RxString forgotPasswordMessage = ''.obs;

  Future<void> forgotPassword(String email) async {
    forgotPasswordState.value = StateValue.loading;

    try {
      await _firebaseService.forgotPassword(
        email: email,
      );

      forgotPasswordState.value = StateValue.loaded;
      forgotPasswordMessage.value = 'check your email';
    } catch (e) {
      forgotPasswordState.value = StateValue.error;

      if (e is RemoteExceptions) {
        forgotPasswordMessage.value = e.errorMsg.toString();
      } else {
        forgotPasswordMessage.value =
            ErrorCode.APP_ERROR.getLocalizedMessage();
      }
    }
  }

  // ===================== LOGOUT =====================

  final Rx<StateValue> logoutState = StateValue.init.obs;
  final RxString logoutMessage = ''.obs;

  Future<void> logout() async {
    logoutState.value = StateValue.loading;

    try {
      await _firebaseService.logout();

      logoutState.value = StateValue.loaded;
      logoutMessage.value = 'success';
    } catch (e) {
      logoutState.value = StateValue.error;

      if (e is RemoteExceptions) {
        logoutMessage.value = e.errorMsg.toString();
      } else {
        logoutMessage.value =
            ErrorCode.APP_ERROR.getLocalizedMessage();
      }
    }
  }
}