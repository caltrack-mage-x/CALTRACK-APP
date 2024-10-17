import '../repository/foodattachment_repository.dart';
import '../models/foodattachment_model.dart';

class FoodAttachmentService {
  final FoodAttachmentRepository _foodAttachmentRepository;

  FoodAttachmentService(this._foodAttachmentRepository);

  Future<List<FoodAttachmentModel>> getAllFoodAttachments() async {
    return await _foodAttachmentRepository.getAllFoodAttachments();
  }

  Future<void> createFoodAttachment(FoodAttachmentModel attachment) async {
    await _foodAttachmentRepository.createFoodAttachment(attachment);
  }

  Future<void> updateFoodAttachment(FoodAttachmentModel attachment) async {
    await _foodAttachmentRepository.updateFoodAttachment(attachment);
  }

  Future<void> deleteFoodAttachment(String attachmentId) async {
    await _foodAttachmentRepository.deleteFoodAttachment(attachmentId);
  }
}
