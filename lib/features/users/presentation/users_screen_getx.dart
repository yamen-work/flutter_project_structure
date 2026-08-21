import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/enums/state_value.dart';
import '../domain/user_entity.dart';
import '../getx/users_controller.dart';

class UsersGetXScreen extends StatefulWidget {
  const UsersGetXScreen({super.key});

  @override
  State<UsersGetXScreen> createState() => _UsersGetXScreenState();
}

class _UsersGetXScreenState extends State<UsersGetXScreen> {
  final UsersController controller = Get.find<UsersController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: errorColor,
        title:  Text('Users',style: mediumWhiteTextStyle,),
      ),
      body: Obx(
        () {
          if (controller.getState.value == StateValue.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.getState.value == StateValue.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.errorMessage.value.isEmpty
                          ? 'Something went wrong'
                          : controller.errorMessage.value,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.getUsers,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.getState.value == StateValue.loaded) {
            if (controller.users.isEmpty) {
              return const Center(
                child: Text('No users found'),
              );
            }

            return RefreshIndicator(
              onRefresh: controller.getUsers,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];

                  return _UserCard(
                    user: user,
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserEntity user;

  const _UserCard({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(
                    user.name.isNotEmpty
                        ? user.name[0].toUpperCase()
                        : '?',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text('@${user.username}'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _InfoRow(
              icon: Icons.email_outlined,
              text: user.email,
            ),

            _InfoRow(
              icon: Icons.phone_outlined,
              text: user.phone,
            ),

            _InfoRow(
              icon: Icons.location_city_outlined,
              text: user.city,
            ),

            _InfoRow(
              icon: Icons.business_outlined,
              text: user.companyName,
            ),

            _InfoRow(
              icon: Icons.language_outlined,
              text: user.website,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}