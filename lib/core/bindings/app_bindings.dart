import 'package:get/get.dart';
import '../../features/auth/getx/auth_controller.dart';
import '../services/firebase/firebase_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseService>(
      FirebaseService.instance,
      permanent: true,
    );

    Get.lazyPut<AuthController>(
          () => AuthController(
        firebaseService: Get.find<FirebaseService>(),
      ),
    );
  }
}