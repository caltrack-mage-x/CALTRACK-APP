import '../repository/userattachment_repository.dart';
import '../models/userattachment_model.dart';

class UserAttachmentService {
  final UserAttachmentRepository _userAttachmentRepository;

  UserAttachmentService(this._userAttachmentRepository);

  Future<List<UserAttachmentModel>> getAllUserAttachments() async {
    return await _userAttachmentRepository.getAllUserAttachments();
  }

  Future<void> createUserAttachment(UserAttachmentModel attachment) async {
    await _userAttachmentRepository.createUserAttachment(attachment);
  }

  Future<void> updateUserAttachment(UserAttachmentModel attachment) async {
    await _userAttachmentRepository.updateUserAttachment(attachment);
  }

  Future<void> deleteUserAttachment(String attachmentId) async {
    await _userAttachmentRepository.deleteUserAttachment(attachmentId);
  }
}
