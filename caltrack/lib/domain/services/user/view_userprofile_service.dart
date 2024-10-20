import 'package:caltrack/domain/models/user/view_userprofile_model.dart';
import 'package:caltrack/domain/repository/user/view_userprofile_repository.dart';

class UserProfileService {
  final UserProfileRepository _userProfileRepository;

  UserProfileService(this._userProfileRepository);

  Future<List<UserProfileModel>> fetchAllUserProfiles() async {
    try {
      return await _userProfileRepository.getAllUserProfiles();
    } catch (e) {
      throw Exception('Failed to load user profiles: $e');
    }
  }

  Future<UserProfileModel?> fetchUserProfile(String userId) async {
    try {
      return await _userProfileRepository.getUserProfile(userId);
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }
}
