import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/foodattachment_model.dart';

class FoodAttachmentRepository {
  final SupabaseClient _client;

  FoodAttachmentRepository(this._client);

  Future<List<FoodAttachmentModel>> getAllFoodAttachments() async {
    final response =
        await _client.from('FoodAttachment').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No food attachments found.');
    }

    return (response as List)
        .map((attachment) => FoodAttachmentModel.fromJson(attachment))
        .toList();
  }

  Future<void> createFoodAttachment(FoodAttachmentModel attachment) async {
    final response = await _client
        .from('FoodAttachment')
        .insert(attachment.toJson())
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to create food attachment.');
    }
  }

  Future<void> updateFoodAttachment(FoodAttachmentModel attachment) async {
    final response = await _client
        .from('FoodAttachment')
        .update(attachment.toJson())
        .eq('attachment_id', attachment.attachmentId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update food attachment.');
    }
  }

  Future<void> deleteFoodAttachment(String attachmentId) async {
    final response = await _client
        .from('FoodAttachment')
        .delete()
        .eq('attachment_id', attachmentId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete food attachment.');
    }
  }
}
