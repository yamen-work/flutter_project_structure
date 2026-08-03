import 'package:exercise_projects/core/models/category.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/widgets/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/models/enums/state_value.dart';
import '../../../core/services/remote_api_service.dart';
import '../controller/category_controller.dart';

class TopicPageGetX extends StatefulWidget {
  const TopicPageGetX({super.key});

  @override
  State<TopicPageGetX> createState() => _TopicPageGetXState();
}

class _TopicPageGetXState extends State<TopicPageGetX> {


  final CategoryController controller = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    controller.getTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "Categories - GetX",
          style: bigWhiteTextStyle,
        ),
      ),
      floatingActionButton: Obx(
            () => FloatingActionButton(
          onPressed: controller.postState.value == StateValue.loading ? null : () {
            controller.addTopic(
              Category(
                categoryName: "New Category",
                categoryList: const ["One", "Two", "Three"],
              ),
            );
          },
          child: controller.postState.value == StateValue.loading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.red,
              strokeWidth: 2,
            ),
          )
              : const Icon(Icons.add, color: Colors.red),
        ),
      ),
      body: Obx(() {
        switch (controller.getState.value) {
          case StateValue.init:
            return const SizedBox();
          case StateValue.loading:
            return const Center(child: CircularProgressIndicator());
          case StateValue.error:
            return Center(child: Text(controller.errorMessage.value));
          case StateValue.loaded:
            return ListView.builder(
              itemCount: controller.topics.length,
              itemBuilder: (_, index) {
                final topic = controller.topics[index];
                return ListTile(
                  title: Text(topic.categoryName),
                  subtitle: Text(topic.categoryList.join(", ")),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditDialog(topic),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteDialog(topic),
                      ),
                    ],
                  ),
                );
              },
            );
        }
      }),
    );
  }

  void _showEditDialog(Category category) {
    final nameController = TextEditingController(text: category.categoryName);
    final listController = TextEditingController(text: category.categoryList.join(", "));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Category"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Category Name",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: listController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Items (comma separated)",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              controller.updateTopic(
                Category(
                  id: category.id,
                  categoryName: nameController.text,
                  categoryList: listController.text
                      .split(",")
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList(),
                ),
              );
              Get.back();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(Category category) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Category"),
        content: Text(
          'Delete \'${category.categoryName}\'?',
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              controller.deleteTopic(category.id!);
              Get.back();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}