import '../../../core/secure_storage/token_storage_interface.dart';
import '../../../core/services/remote_api_service.dart';

class AuthRemoteDataSource {

  final RemoteApiService _api;

  final TokenStorage _tokenStorage;

  AuthRemoteDataSource({
    required RemoteApiService api,
    required TokenStorage tokenStorage,
  }) : _api = api,
       _tokenStorage = tokenStorage;

  Future<void> login({required String email, required String password}) async {
    final response = await _api.postRequest('/new_account/customer/login', {
      'email': email,
      'password': password,
    });

    final accessToken = response.data['access_token'];

    await _tokenStorage.saveAccessToken(accessToken);
  }
}
