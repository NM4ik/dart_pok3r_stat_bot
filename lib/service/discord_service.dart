import 'package:nyxx/nyxx.dart';

class DiscordService {
  void onListen(IMessageReceivedEvent event) async {
    final call = event.message.content;

    print('call = $call');

    switch (call) {
      case 'create':
      // return _onCreate()
    }

    print('get message = ${event.message.content}');
  }
}
