import '../../repository/user/user_repository.dart';
import '../../models/user/user_model.dart';

class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepository.getAllUsers();
  }

  Future<void> createUser(UserModel user) async {
    await _userRepository.createUser(user);
  }

  Future<void> updateUser(UserModel user) async {
    await _userRepository.updateUser(user);
  }

  Future<void> deleteUser(String userId) async {
    await _userRepository.deleteUser(userId);
  }
}
