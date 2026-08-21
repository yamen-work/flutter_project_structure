import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/enums/state_value.dart';
import '../../../core/resources/colors_and_styles.dart';
import '../bloc/users_cubit.dart';
import '../bloc/users_state.dart';
import '../domain/user_entity.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersCubit>().getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title:  Text('Users',style: mediumWhiteTextStyle,),
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state.getState == StateValue.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.getState == StateValue.error) {
            return _ErrorView(
              message: state.getError,
              onRetry: () {
                context.read<UsersCubit>().getUsers();
              },
            );
          }

          if (state.getState == StateValue.loaded) {
            if (state.users.isEmpty) {
              return const Center(
                child: Text('No users found'),
              );
            }

            return RefreshIndicator(
              onRefresh: () {
                return context.read<UsersCubit>().getUsers();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '@${user.username}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
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

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.phone_outlined,
              text: user.phone,
            ),

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.location_city_outlined,
              text: user.city,
            ),

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.business_outlined,
              text: user.companyName,
            ),

            const SizedBox(height: 8),

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
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
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
              message.isEmpty
                  ? 'Something went wrong'
                  : message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}