import 'package:exercise_projects/core/secure_storage/token_storage_implementation.dart';
import 'package:exercise_projects/core/secure_storage/token_storage_interface.dart';
import 'package:exercise_projects/core/services/remote_api_service.dart';
import 'package:exercise_projects/features/auth/data/auth_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../features/category_screen_getx/controller/category_controller.dart';
import '../../features/users/data/data_sources/local_data_source.dart';
import '../../features/users/data/data_sources/remote_data_source.dart';
import '../../features/users/data/reposititories/users_repo_implementation.dart';
import '../../features/users/domain/repositories_interfaces/users_repo_interface.dart';
import '../../features/users/domain/use_cases/get_users_use_case.dart';
import '../../features/users/getx/users_controller.dart';

class AppBindings extends Bindings{

  @override
  void dependencies() {

    Get.put(SecureTokenStorage(FlutterSecureStorage()));

    Get.put(RemoteApiService(Get.find<SecureTokenStorage>()));

    Get.put(AuthRemoteDataSource(api:Get.find<RemoteApiService>(),tokenStorage: Get.find<SecureTokenStorage>()));

// ================= REMOTE =================

    Get.lazyPut<UserRemoteDataSource>(
          () => UserRemoteDataSource(
        Get.find<RemoteApiService>(),
      ),
    );

    // ================= LOCAL =================

    Get.lazyPut<UserLocalDataSource>(
            () => UserLocalDataSource()
    );

    // ================= REPOSITORY =================

    Get.lazyPut<UserRepository>(
          () => UserRepositoryImpl(
        Get.find<UserRemoteDataSource>(),
        Get.find<UserLocalDataSource>(),
      ),
      fenix: true,
    );

    // ================= USE CASE =================

    Get.lazyPut<GetUsersUseCase>(
          () => GetUsersUseCase(
        Get.find<UserRepository>(),
      ),
    );

    Get.lazyPut<UsersController>(
          () => UsersController(
        getUsersUseCase:
        Get.find<GetUsersUseCase>(),
      ),
    );

    Get.put(CategoryController());
  }
}