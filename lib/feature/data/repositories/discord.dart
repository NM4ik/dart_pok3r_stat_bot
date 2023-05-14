import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:pok3r_bot/feature/data/repositories/user.dart';
import 'package:pok3r_bot/feature/domain/repositories/discord.dart';

class DiscordCommands extends IDiscordCommands {
  final _userRepository = UserRepository();

  @override
  void onListen(IMessageReceivedEvent event) {
    // final data = switch (event.message.content) {
    //   1 => 'Чувствуете хандру понедельника?',
    //   6 || 7 => 'Наслаждайтесь выходными!',
    //   _ => 'Держись.'
    // };

    // // switch (0) {
    // //   0 => 'string',
    // //   1 || 2 =>
    // // }
  }

  @override
  CommandsPlugin get commands => CommandsPlugin(
        prefix: (message) => '!',
        options: CommandsOptions(
          logErrors: true,
        ),
      );

  @override
  ChatCommand get createUserChatCommand => ChatCommand(
        'создать_пользователя',
        'Создать учетную запись для ведения дневника покериста',
        (IChatContext context, String message) {
          context.respond(MessageBuilder.content(message));
          print('mess - $message');
          _userRepository.createUser(message);
        },
      );
}
