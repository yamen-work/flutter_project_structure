import 'package:exercise_projects/core/models/enums/state_value.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/category.dart';
import '../../../core/widgets/flushbar.dart';
import '../bloc/categories_bloc.dart';
import '../bloc/categories_state.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {

  @override
  void initState() {
    BlocProvider.of<CategoriesCubit>(context).getTopics();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title:  Text("Categories - Bloc",style: bigWhiteTextStyle ,),
      ),
      floatingActionButton: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state.postState == StateValue.loading
                ? null
                : () {
              context.read<CategoriesCubit>().addTopic(
                Category(
                  categoryName: "Session Test",
                  categoryList: const [
                    "Bayan",
                    "Rashed",
                    "Rami",
                  ],
                ),
              );
            },
            child: state.postState == StateValue.loading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : const Icon(Icons.add),
          );
        },
      ),


      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listenWhen: (previous, current) {
          return previous.getState != current.getState ||
              previous.postState != current.postState ||
              previous.putState != current.putState ||
              previous.deleteState != current.deleteState;
        },
        listener: (context, state) {

          if (state.postState == StateValue.error) {
            showSimpleFlushBar(
              context,
              "Add Failed",
              state.postError ?? "Unknown Error",
              Icons.error,
              Colors.red,
            );
          }

          if (state.putState == StateValue.error) {
            showSimpleFlushBar(
              context,
              "Update Failed",
              state.putError ?? "Unknown Error",
              Icons.error,
              Colors.red,
            );
          }

          if (state.deleteState == StateValue.error) {
            showSimpleFlushBar(
              context,
              "Delete Failed",
              state.deleteError ?? "Unknown Error",
              Icons.error,
              Colors.red,
            );
          }

          if (state.postState == StateValue.loaded) {
            showSimpleFlushBar(
              context,
              "Success",
              "Category added successfully",
              Icons.check_circle,
              Colors.green,
            );
          }

          if (state.putState == StateValue.loaded) {
            showSimpleFlushBar(
              context,
              "Success",
              "Category updated successfully",
              Icons.check_circle,
              Colors.green,
            );
          }

          if (state.deleteState == StateValue.loaded) {
            showSimpleFlushBar(
              context,
              "Success",
              "Category deleted successfully",
              Icons.check_circle,
              Colors.green,
            );
          }
        },
        builder: (context, state) {
          switch (state.getState) {
            case StateValue.init:
              return const SizedBox();

            case StateValue.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case StateValue.error:
              return Center(
                child: Text(state.getError ?? "Unknown Error"),
              );

            case StateValue.loaded:
              return ListView.builder(
                itemCount: state.topics.length,
                itemBuilder: (_, index) {
                  final category = state.topics[index];

                  return ListTile(
                    title: Text(category.categoryName),
                    subtitle: Text(
                      category.categoryList.join(", "),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _showEditDialog(category);
                          },
                        ),
                        state.deleteState == StateValue.loading
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                            : IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _showDeleteDialog(category);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }

  void _showEditDialog(Category category) {
    final nameController = TextEditingController(
      text: category.categoryName,
    );

    final listController = TextEditingController(
      text: category.categoryList.join(", "),
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
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
              onPressed: Navigator.of(context).pop,
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CategoriesCubit>().editTopic(
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

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(Category category) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Category"),
          content: Text(
            "Delete '${category.categoryName}'?",
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                context.read<CategoriesCubit>().deleteTopic(
                  category,
                );

                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
