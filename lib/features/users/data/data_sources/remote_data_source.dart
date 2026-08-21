import '../../../../core/services/remote_api_service.dart';
import '../user_model.dart';

class UserRemoteDataSource {

  final RemoteApiService remoteApiService;

  UserRemoteDataSource(this.remoteApiService);

  Future<List<UserModel>> getUsers() async {
    final response = await remoteApiService.getRequest('/users');

    final List data = response.data;

    return data.map((json) => UserModel.fromJson(json),).toList();
  }
}