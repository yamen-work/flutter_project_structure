import 'package:exercise_projects/core/secure_storage/token_storage_implementation.dart';
import 'package:exercise_projects/core/secure_storage/token_storage_interface.dart';
import 'package:exercise_projects/core/services/remote_api_service.dart';
import 'package:exercise_projects/features/auth/data/auth_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../features/category_screen_getx/controller/category_controller.dart';

class AppBindings extends Bindings{

  @override
  void dependencies() {

    Get.put(SecureTokenStorage(FlutterSecureStorage()));

    Get.put(RemoteApiService(Get.find<SecureTokenStorage>()));

    Get.put(AuthRemoteDataSource(api:Get.find<RemoteApiService>(),tokenStorage: Get.find<SecureTokenStorage>()));

    // Get.put(AuthController(Get.find<AuthRemoteDataSource>());


    Get.put(CategoryController());
  }
}