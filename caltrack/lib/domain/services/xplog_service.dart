import '../repository/xplog_repository.dart';
import '../models/xplog_model.dart';

class XPLogService {
  final XPLogRepository _xpLogRepository;

  XPLogService(this._xpLogRepository);

  Future<List<XPLogModel>> getAllXPLogs() async {
    return await _xpLogRepository.getAllXPLogs();
  }

  Future<void> createXPLog(XPLogModel xpLog) async {
    await _xpLogRepository.createXPLog(xpLog);
  }

  Future<void> updateXPLog(XPLogModel xpLog) async {
    await _xpLogRepository.updateXPLog(xpLog);
  }

  Future<void> deleteXPLog(String xpLogId) async {
    await _xpLogRepository.deleteXPLog(xpLogId);
  }
}
