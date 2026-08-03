import 'package:exercise_projects/core/services/remote_api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../features/category_screen_getx/controller/category_controller.dart';

class AppBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(RemoteApiService());
    Get.put(CategoryController());
  }
}