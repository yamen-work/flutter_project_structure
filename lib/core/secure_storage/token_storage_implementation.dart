import 'package:exercise_projects/core/secure_storage/token_storage_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureTokenStorage implements TokenStorage {

  final FlutterSecureStorage _storage;

  SecureTokenStorage(this._storage);

  static const String _accessTokenKey = 'token';

  @override
  Future<String?> getAccessToken() {
    return _storage.read(key: _accessTokenKey);
  }
  @override
  Future<void> saveAccessToken(String token) {
    return _storage.write(key: _accessTokenKey, value: token);
  }
  @override
  Future<void> clearAccessToken() {
    return _storage.delete(key: _accessTokenKey);
  }
}
