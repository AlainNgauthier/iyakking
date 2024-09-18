import 'package:iyakking/models/yakking_message.dart';
import 'package:iyakking/models/yakking_user.dart';
import 'package:iyakking/services/yakking/yak_mock_service.dart';

abstract class YakService {
  // realtime messages
  Stream<List<YakMessage>> messagesStream();

  // to save new messages
  Future<YakMessage> save(String text, YakkingUser user);

  factory YakService() {
    return YakMockService();
  }
}
