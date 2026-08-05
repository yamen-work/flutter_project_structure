import 'dart:io';
import 'package:exercise_projects/core/models/enums/state_value.dart' as reviews_screen;
import 'package:exercise_projects/core/models/review_model.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/features/review_screen/bloc/review_bloc.dart';
import 'package:exercise_projects/features/review_screen/bloc/review_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/models/category.dart';
import '../../../core/widgets/flushbar.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {

  List<PlatformFile> selectedImages = [];

  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result == null) return;
    setState(() {
      selectedImages = result.files;
    });
  }

  @override
  void initState() {
    BlocProvider.of<ReviewsCubit>(context).getReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Reviews - Bloc", style: bigWhiteTextStyle),
      ),
      floatingActionButton: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state.postState == reviews_screen.StateValue.loading
                ? null
                : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddReviewScreen(
                    onImagesPicked: (newFiles) {
                      setState(() {
                        selectedImages = newFiles;
                      });
                    },
                  ),
                ),
              );
            },
            child: state.postState == reviews_screen.StateValue.loading
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
      body: BlocConsumer<ReviewsCubit, ReviewsState>(
        listenWhen: (previous, current) {
          return previous.getState != current.getState ||
              previous.postState != current.postState ||
              previous.putState != current.putState ||
              previous.deleteState != current.deleteState;
        },
        listener: (context, state) {
          if (state.postState == reviews_screen.StateValue.error) {
            showSimpleFlushBar(
              context,
              "Add Failed",
              state.postError ?? "Unknown Error",
              Icons.error,
              Colors.red,
            );
          }
          if (state.putState == reviews_screen.StateValue.error) {
            showSimpleFlushBar(
              context,
              "Update Failed",
              state.putError ?? "Unknown Error",
              Icons.error,
              Colors.red,
            );
          }
          if (state.deleteState == reviews_screen.StateValue.error) {
            showSimpleFlushBar(
              context,
              "Delete Failed",
              state.deleteError ?? "Unknown Error",
              Icons.error,
              Colors.red,
            );
          }
          if (state.postState == reviews_screen.StateValue.loaded) {
            showSimpleFlushBar(
              context,
              "Success",
              "Review added successfully",
              Icons.check_circle,
              Colors.green,
            );
          }
          if (state.putState == reviews_screen.StateValue.loaded) {
            showSimpleFlushBar(
              context,
              "Success",
              "Review updated successfully",
              Icons.check_circle,
              Colors.green,
            );
          }
          if (state.deleteState == reviews_screen.StateValue.loaded) {
            showSimpleFlushBar(
              context,
              "Success",
              "Review deleted successfully",
              Icons.check_circle,
              Colors.green,
            );
          }
        },
        builder: (context, state) {
          switch (state.getState) {
            case reviews_screen.StateValue.init:
              return const SizedBox();
            case reviews_screen.StateValue.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case reviews_screen.StateValue.error:
              return Center(
                child: Text(state.getError ?? "Unknown Error"),
              );
            case reviews_screen.StateValue.loaded:
              return ListView.builder(
                itemCount: state.reviews.length,
                itemBuilder: (_, index) {
                  final review = state.reviews[index];
                  return ListTile(
                    title: Text(review.game),
                    subtitle: Text(
                      review.name,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditReviewScreen(
                                  review: review,
                                  onImagesPicked: (newFiles) {
                                    setState(() {
                                      selectedImages = newFiles;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        state.deleteState == reviews_screen.StateValue.loading
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
                            _showDeleteDialog(review);
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

  // ================================================
  // DELETE DIALOG (now shown as bottom sheet for consistency with "no dialogs")
  // ================================================
  void _showDeleteDialog(ReviewModel review) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Delete Review',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Delete "${review.game}"?',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        context.read<ReviewsCubit>().deleteReview(review.id!);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Delete"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ================================================
// ADD REVIEW SCREEN (replaces AddReviewDialog)
// ================================================
class AddReviewScreen extends StatefulWidget {
  final void Function(List<PlatformFile> newFiles) onImagesPicked;

  const AddReviewScreen({
    super.key,
    required this.onImagesPicked,
  });

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  late TextEditingController gameController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController ratingController;
  late TextEditingController messageController;

  final List<PlatformFile> _selectedImages = [];


  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    gameController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController(text: "yamen@gmail.com");
    ratingController = TextEditingController(text: "5");
    messageController = TextEditingController(text: "amazing game");
    super.initState();
  }

  @override
  void dispose() {
    gameController.dispose();
    nameController.dispose();
    emailController.dispose();
    ratingController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Review"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: gameController,
              decoration: const InputDecoration(
                labelText: "Game Name",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Reviewer Name",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: ratingController,
              decoration: const InputDecoration(
                labelText: "Rating (1-5)",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Message",
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.pickFiles(
                        allowMultiple: true,
                        type: FileType.image,
                      );
                      if (result != null && result.files.isNotEmpty) {
                        setState(() {
                          _selectedImages.addAll(result.files);
                        });
                        widget.onImagesPicked(_selectedImages);
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Pick Images"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_selectedImages.isNotEmpty)
              Text(
                "${_selectedImages.length} image(s) selected",
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
            if (_selectedImages.isNotEmpty) ...[
              const SizedBox(height: 15),
              const Text(
                "Selected Images:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, i) {
                    final file = _selectedImages[i];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(file.path!),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final game = gameController.text.trim();
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final message = messageController.text.trim();
                final ratingStr = ratingController.text.trim();
                if (game.isEmpty || name.isEmpty || email.isEmpty || message.isEmpty || ratingStr.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("All fields are required")),
                  );
                  return;
                }
                final rating = int.tryParse(ratingStr);
                if (rating == null || rating < 1 || rating > 5) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Rating must be between 1 and 5")),
                  );
                  return;
                }

                context.read<ReviewsCubit>().addReview(
                  ReviewModel(
                    game: game,
                    name: name,
                    email: email,
                    rating: rating,
                    message: message,
                    imageUrls: [],
                    imageFiles: _selectedImages,
                  ),
                );

                Navigator.of(context).pop();
              },
              child: const Text("Add Review"),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================
// EDIT REVIEW SCREEN (replaces EditReviewDialog)
// ================================================
class EditReviewScreen extends StatefulWidget {
  final ReviewModel review;
  final void Function(List<PlatformFile> newFiles) onImagesPicked;

  const EditReviewScreen({
    super.key,
    required this.review,
    required this.onImagesPicked,
  });

  @override
  State<EditReviewScreen> createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {
  late TextEditingController gameController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController ratingController;
  late TextEditingController messageController;

  final List<PlatformFile> _selectedImages = [];

  @override
  void initState() {
    gameController = TextEditingController(text: widget.review.game);
    nameController = TextEditingController(text: widget.review.name);
    emailController = TextEditingController(text: widget.review.email);
    ratingController = TextEditingController(text: widget.review.rating.toString());
    messageController = TextEditingController(text: widget.review.message);
    super.initState();
  }

  @override
  void dispose() {
    gameController.dispose();
    nameController.dispose();
    emailController.dispose();
    ratingController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Review"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: gameController,
              decoration: const InputDecoration(
                labelText: "Game Name",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Reviewer Name",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: ratingController,
              decoration: const InputDecoration(
                labelText: "Rating (1-5)",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Message",
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.pickFiles(
                        allowMultiple: true,
                        type: FileType.image,
                      );
                      if (result != null && result.files.isNotEmpty) {
                        setState(() {
                          _selectedImages.addAll(result.files);
                        });
                        widget.onImagesPicked(_selectedImages);
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Pick Images"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_selectedImages.isNotEmpty)
              Text(
                "${_selectedImages.length} image(s) selected",
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
            if (_selectedImages.isNotEmpty) ...[
              const SizedBox(height: 15),
              const Text(
                "Selected Images:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, i) {
                    final file = _selectedImages[i];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(file.path!),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 15),
            const Text(
              "Existing Images:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.review.imageUrls.length,
                itemBuilder: (context, i) {
                  final url = widget.review.imageUrls[i];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                       "https://yamen146.pythonanywhere.com"+ url,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final game = gameController.text.trim();
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final message = messageController.text.trim();
                final ratingStr = ratingController.text.trim();
                if (game.isEmpty || name.isEmpty || email.isEmpty || message.isEmpty || ratingStr.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("All fields are required")),
                  );
                  return;
                }
                final rating = int.tryParse(ratingStr);
                if (rating == null || rating < 1 || rating > 5) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Rating must be between 1 and 5")),
                  );
                  return;
                }

                context.read<ReviewsCubit>().updateReview(
                  ReviewModel(
                    id: widget.review.id,
                    game: game,
                    name: name,
                    email: email,
                    rating: rating,
                    message: message,
                    imageUrls: widget.review.imageUrls,
                    imageFiles: _selectedImages,
                  ),
                );

                Navigator.of(context).pop();
              },
              child: const Text("Save Review"),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================
// DELETE REVIEW SCREEN (replaces DeleteReviewDialog)
// ================================================
class DeleteReviewScreen extends StatelessWidget {
  final ReviewModel review;

  const DeleteReviewScreen({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Review"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete "${review.game}"?',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    context.read<ReviewsCubit>().deleteReview(review.id!);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}