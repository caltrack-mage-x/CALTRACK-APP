// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/xplog_model.dart';
import 'package:flutter/cupertino.dart';

class XPLogRepository {
  final SupabaseClient _client;

  XPLogRepository(this._client);

  Future<List<XPLogModel>> getAllXPLogs() async {
    final response = await _client.from('XPLog').select();

    debugPrint('getAllXPLogs Response: $response');

    if ((response).isEmpty) {
      debugPrint('No XP logs found.');
      throw Exception('No XP logs found.');
    }

    return (response)
        .map((xpLog) => XPLogModel.fromJson(xpLog))
        .toList();
  }

  Future<void> createXPLog(XPLogModel xpLog) async {
    final response = await _client.from('XPLog').insert(xpLog.toJson());

    debugPrint('createXPLog Response: $response');

    if (response == null) {
      debugPrint('Failed to create XP log.');
      throw Exception('Failed to create XP log.');
    }
  }

  Future<void> updateXPLog(XPLogModel xpLog) async {
    final response = await _client
        .from('XPLog')
        .update(xpLog.toJson())
        .eq('xp_log_id', xpLog.xpLogId);

    debugPrint('updateXPLog Response: $response');

    if (response == null) {
      debugPrint('Failed to update XP log.');
      throw Exception('Failed to update XP log.');
    }
  }

  Future<void> deleteXPLog(String xpLogId) async {
    final response = await _client
        .from('XPLog')
        .delete()
        .eq('xp_log_id', xpLogId);

    debugPrint('deleteXPLog Response: $response');

    if (response == null) {
      debugPrint('Failed to delete XP log.');
      throw Exception('Failed to delete XP log.');
    }
  }
}
