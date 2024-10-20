// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/food/foodattachment_model.dart';
import 'package:flutter/foundation.dart';

class FoodAttachmentRepository {
  final SupabaseClient _client;

  FoodAttachmentRepository(this._client);

  Future<List<FoodAttachmentModel>> getAllFoodAttachments() async {
    final response = await _client.from('FoodAttachment').select();

    debugPrint('getAllFoodAttachments Response: $response');

    if ((response).isEmpty) {
      debugPrint('No food attachments found.');
      throw Exception('No food attachments found.');
    }

    return (response)
        .map((attachment) => FoodAttachmentModel.fromJson(attachment))
        .toList();
  }

  Future<void> createFoodAttachment(FoodAttachmentModel attachment) async {
    final response = await _client
        .from('FoodAttachment')
        .insert(attachment.toJson());

    if (response == null) {
      debugPrint('Failed to create food attachment.');
      throw Exception('Failed to create food attachment.');
    }
  }

  Future<void> updateFoodAttachment(FoodAttachmentModel attachment) async {
    final response = await _client
        .from('FoodAttachment')
        .update(attachment.toJson())
        .eq('attachment_id', attachment.attachmentId);

    if (response == null) {
      debugPrint('Failed to update food attachment.');
      throw Exception('Failed to update food attachment.');
    }
  }

  Future<void> deleteFoodAttachment(String attachmentId) async {
    final response = await _client
        .from('FoodAttachment')
        .delete()
        .eq('attachment_id', attachmentId);

    if (response == null) {
      debugPrint('Failed to delete food attachment.');
      throw Exception('Failed to delete food attachment.');
    }
  }
}
