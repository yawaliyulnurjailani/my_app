import '../repositories/auth_repositories.dart';

final _authRepositories = AuthRepositories();

class MainService {
  AuthRepositories get authRepositories => _authRepositories;
}
