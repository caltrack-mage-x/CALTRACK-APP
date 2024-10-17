import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/xplog_model.dart';

class XPLogRepository {
  final SupabaseClient _client;

  XPLogRepository(this._client);

  Future<List<XPLogModel>> getAllXPLogs() async {
    final response = await _client.from('XPLog').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No XP logs found.');
    }

    return (response as List)
        .map((xpLog) => XPLogModel.fromJson(xpLog))
        .toList();
  }

  Future<void> createXPLog(XPLogModel xpLog) async {
    final response =
        await _client.from('XPLog').insert(xpLog.toJson()).maybeSingle();

    if (response == null) {
      throw Exception('Failed to create XP log.');
    }
  }

  Future<void> updateXPLog(XPLogModel xpLog) async {
    final response = await _client
        .from('XPLog')
        .update(xpLog.toJson())
        .eq('xp_log_id', xpLog.xpLogId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update XP log.');
    }
  }

  Future<void> deleteXPLog(String xpLogId) async {
    final response = await _client
        .from('XPLog')
        .delete()
        .eq('xp_log_id', xpLogId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete XP log.');
    }
  }
}
