import 'package:nyxx/nyxx.dart';
import 'package:pok3r_bot/core/config.dart';
import 'package:pok3r_bot/feature/data/repositories/discord.dart';

class Discord {
  INyxxWebsocket? pokerBot;

  final ds = DiscordCommands();

  Future<void> create() async {
    pokerBot = NyxxFactory.createNyxxWebsocket(dsBotToken,
        GatewayIntents.allUnprivileged | GatewayIntents.messageContent)
      ..registerPlugin(Logging())
      ..registerPlugin(CliIntegration())
      ..registerPlugin(IgnoreExceptions())
      ..registerPlugin(ds.commands..addCommand(ds.createUserChatCommand));

    await pokerBot!.connect();
  }

  EmbedBuilder _buildMessage(IMessageReceivedEvent e, String messageAnswer) =>
      EmbedBuilder()
        ..addField(
          name: 'Пользователь [$messageAnswer] успешно создан',
          content: '',
        )
        ..addFooter((footer) {
          footer.text = e.message.author.username;
          footer.iconUrl = e.message.author.avatarUrl();
        })
        ..color = DiscordColor.aquamarine;
}
