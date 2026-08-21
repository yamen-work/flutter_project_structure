import '../../domain/repositories_interfaces/users_repo_interface.dart';
import '../../domain/user_entity.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../user_model.dart';

class UserRepositoryImpl implements UserRepository {


  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final bool isConnected;

  UserRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,{
    this.isConnected= true,
  }
  );

  @override
  Future<List<UserEntity>> getUsers() async {

    List<UserModel> users;

    if (isConnected) {
      users = await remoteDataSource.getUsers();

      await localDataSource.saveUsers(users);
    } else {
      users = await localDataSource.getUsers();
    }

    return users.map((user) => user.toEntity()).toList();
  }
}