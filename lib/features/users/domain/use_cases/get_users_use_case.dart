import '../repositories_interfaces/users_repo_interface.dart';
import '../user_entity.dart';

class GetUsersUseCase {

  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<List<UserEntity>> call() {

    return repository.getUsers();
  }
}