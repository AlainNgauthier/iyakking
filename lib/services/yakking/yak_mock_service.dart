import 'dart:async';
import 'dart:math';

import 'package:iyakking/models/yakking_message.dart';
import 'package:iyakking/models/yakking_user.dart';
import 'package:iyakking/services/yakking/yak_service.dart';

class YakMockService implements YakService {
  static final List<YakMessage> _msgs = [];

  static MultiStreamController<List<YakMessage>>? _controller;
  static final _msgsStream = Stream<List<YakMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs);
  });

  Stream<List<YakMessage>> messagesStream() {
    return _msgsStream;
  }

  Future<YakMessage> save(String text, YakkingUser user) async {
    final newMessage = YakMessage(
        id: Random().nextDouble().toString(),
        text: text,
        createdAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageURL: user.imageURL);
    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());
    return newMessage;
  }
}
