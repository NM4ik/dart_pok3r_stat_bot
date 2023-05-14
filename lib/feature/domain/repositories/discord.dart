import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

abstract class IDiscordCommands {
  /// listen stream for interactive user
  void onListen(IMessageReceivedEvent event);

  /// commands line call for discord bot
  CommandsPlugin get commands;

  /// create user command
  ChatCommand get createUserChatCommand;
}
