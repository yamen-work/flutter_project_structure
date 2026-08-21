import 'package:get/get.dart';

import '../../../core/errors/remote_excpetions.dart';
import '../../../core/models/enums/state_value.dart';
import '../domain/use_cases/get_users_use_case.dart';
import '../domain/user_entity.dart';

class UsersController extends GetxController {

  final GetUsersUseCase getUsersUseCase;

  UsersController({
    required this.getUsersUseCase,
  });

  // ================= STATES =================

  final Rx<StateValue> getState = StateValue.init.obs;

  // ================= DATA =================

  final RxList<UserEntity> users = <UserEntity>[].obs;

  final RxString errorMessage = ''.obs;

  Future<void> getUsers() async {
    try {
      getState.value = StateValue.loading;
      errorMessage.value = '';

      final result = await getUsersUseCase();

      users.assignAll(result);

      getState.value = StateValue.loaded;
    } on RemoteExceptions catch (e) {
      errorMessage.value = e.errorMsg;
      getState.value = StateValue.error;
    } catch (e) {
      errorMessage.value = 'Something went wrong';
      getState.value = StateValue.error;
    }
  }
}