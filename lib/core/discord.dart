import 'package:nyxx/nyxx.dart';
import 'package:pok3r_bot/core/config.dart';

class Discord {
  INyxxWebsocket? pokerBot;

  Future<void> create() async {
    pokerBot = NyxxFactory.createNyxxWebsocket(
        dsBotToken,
        GatewayIntents.allUnprivileged |
            GatewayIntents
                .messageContent) // Here we use the privilegied intent message content to receive incoming messages.
      ..registerPlugin(Logging()) // Default logging plugin
      ..registerPlugin(
          CliIntegration()) // Cli integration for nyxx allows stopping application via SIGTERM and SIGKILl
      ..registerPlugin(
          IgnoreExceptions()) // Plugin that handles uncaught exceptions that may occur
      ..connect().then((value) {
        pokerBot?.eventsWs.onMessageReceived
            .listen((IMessageReceivedEvent event) async {
          final msg = event.message.content;

          print('get message = $msg');

          if (msg == 'create') {
            final embed = _buildMessage(event, 'Никита Михайлов');

            await event.message.channel
                .sendMessage(MessageBuilder.embed(embed));
          }
        });
      });
  }

  EmbedBuilder _buildMessage(IMessageReceivedEvent e, String messageAnswer) =>
      EmbedBuilder()
        ..addField(
          name: 'Пользователь [$messageAnswer] успешно создан',
          content: '',
          builder: (field) => EmbedFieldBuilder(
            'qweqwe',
            '123123123',
          ),
          field: EmbedFieldBuilder(
            'gkhjkhjkhjk',
            'hjkhjkhjkhjk',
          ),
        )
        ..addFooter((footer) {
          footer.text = e.message.author.username;
          footer.iconUrl = e.message.author.avatarUrl();
        })
        ..color = DiscordColor.aquamarine;
}
