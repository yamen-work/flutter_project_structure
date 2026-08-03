import 'package:get/get.dart';
import '../../../core/models/category.dart';
import '../../../core/models/enums/state_value.dart';
import '../../../core/services/remote_api_service.dart';

class CategoryController extends GetxController {

  RemoteApiService service = Get.find<RemoteApiService>();

  CategoryController();

  // ================= STATES =================

  Rx<StateValue> getState = StateValue.init.obs;
  Rx<StateValue> postState = StateValue.init.obs;
  Rx<StateValue> putState = StateValue.init.obs;
  Rx<StateValue> deleteState = StateValue.init.obs;

  // ================= DATA =================

  RxList<Category> topics = <Category>[].obs;

  RxString errorMessage = "".obs;

  Future<void> getTopics() async {
    try {
      getState.value = StateValue.loading;

      final response = await service.getRequest("/topics/");

      topics.value = (response.data["data"] as List)
          .map((e) => Category.fromJson(e))
          .toList();

      getState.value = StateValue.loaded;
    } catch (e) {
      errorMessage.value = e.toString();
      getState.value = StateValue.error;
    }
  }

  Future<void> addTopic(Category category) async {
    try {
      postState.value = StateValue.loading;

      await service.postRequest("/topics/", category.toJson());

      postState.value = StateValue.loaded;

      await getTopics();
    } catch (e) {
      errorMessage.value = e.toString();
      postState.value = StateValue.error;
    }
  }

  Future<void> updateTopic(Category category) async {
    try {
      putState.value = StateValue.loading;

      await service.putRequest("/topics/${category.id}/", category.toJson());

      putState.value = StateValue.loaded;

      await getTopics();
    } catch (e) {
      errorMessage.value = e.toString();
      putState.value = StateValue.error;
    }
  }

  Future<void> deleteTopic(int id) async {
    try {
      deleteState.value = StateValue.loading;

      await service.deleteRequest("/topics/",id.toString());

      deleteState.value = StateValue.loaded;

      await getTopics();
    } catch (e) {
      errorMessage.value = e.toString();
      deleteState.value = StateValue.error;
    }
  }
}