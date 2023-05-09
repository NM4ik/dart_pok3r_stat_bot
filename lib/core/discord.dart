import 'dart:io';
import 'dart:math';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:pok3r_bot/core/config.dart';

import '../service/discord_service.dart';

class Discord {
  INyxxWebsocket? pokerBot;

  Future<void> create() async {
    pokerBot = NyxxFactory.createNyxxWebsocket(dsBotToken,
        GatewayIntents.allUnprivileged | GatewayIntents.messageContent)
      ..registerPlugin(Logging())
      ..registerPlugin(CliIntegration())
      ..registerPlugin(IgnoreExceptions())
      ..registerPlugin(commands
        ..addCommand(ping)
        ..addCommand(nick)
        ..addCommand(cock)
        ..addCommand(say)
        ..addCommand(throwGroup))
      ..connect().then((value) {
        // pokerBot?.eventsWs.onMessageReceived.listen(DiscordService().onListen);
      });
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

  ChatCommand ping = ChatCommand(
    'ping',
    "Checks if the bot's online",
    (IChatContext context) {
      // For a ping command, all we need to do is respond with `pong`.
      // To do that, we can use the `Context`'s `respond` method which responds to the command with
      // a message.
      context.respond(MessageBuilder.content('pong!'));
    },
  );

  ChatCommand cock = ChatCommand(
    'zeng',
    "Checks if the bot's online",
    (IChatContext context) {
      // For a ping command, all we need to do is respond with `pong`.
      // To do that, we can use the `Context`'s `respond` method which responds to the command with
      // a message.
      context.respond(MessageBuilder.content('pong!'));
    },
  );

  ChatGroup throwGroup = ChatGroup(
    'throw',
    'Throw an object',
    children: [
      // We create a command in the same way as we created the `ping` command earlier.
      ChatCommand(
        'coin',
        'Throw a coin',
        (IChatContext context) {
          bool heads = Random().nextBool();

          context.respond(
            MessageBuilder.content(
                'The coin landed on its ${heads ? 'head' : 'tail'}!'),
          );
        },
      ),

      ChatCommand('die', 'Throw a die', (IChatContext context) {
        int number = Random().nextInt(6) + 1;

        context
            .respond(MessageBuilder.content('The die landed on the $number!'));
      }),
    ],
  );

  ChatCommand say = ChatCommand(
    'say',
    'Make the bot say something',
    // As mentioned earlier, all we need to do to add an argument to our command is add it as a
    // parameter to our execute function. In this case, we take an argument called `message` and of
    // type `String`.
    (IChatContext context, String message) {
      context.respond(MessageBuilder.content(message));
    },
  );

  ChatCommand nick = ChatCommand(
    'nick',
    "Change a user's nickname",
    // Setting the type of the `target` parameter to `IMember` will make nyxx_commands convert user
    // input to instances of `IMember`.
    (IChatContext context, IMember target, String newNick) async {
      try {
        await target.edit(builder: MemberBuilder(nick: newNick));
      } on IHttpResponseError {
        context.respond(MessageBuilder.content("Couldn't change nickname :/"));
        return;
      }
      context.respond(MessageBuilder.content('Successfully changed nickname!'));
    },
  );

  CommandsPlugin commands = CommandsPlugin(
    // The `prefix` parameter determines what prefix nyxx_commands will use for text commands.
    //
    // It isn't a simple string but a function that takes a single argument, an `IMessage`, and
    // returns a `String` indicating what prefix to use for that message. This allows you to have
    // different prefixes for different messages, for example you might want the bot to not require
    // a prefix when in direct messages. In that case, you might provide a function like this:
    // ```dart
    // prefix: (message) {
    //   if (message.startsWith('!')) {
    //     return '!';
    //   } else if (message.guild == null) {
    //     return '';
    //   }
    // }
    //```
    //
    // In this case, we always return `!` meaning that the prefix for all messages will be `!`.
    prefix: (message) => '!',

    // The `guild` parameter determines what guild slash commands will be registered to by default.
    //
    // This is useful for testing since registering slash commands globally can take up to an hour,
    // whereas registering commands for a single guild is instantaneous.
    //
    // If you aren't testing or want your commands to be registered globally, either omit this
    // parameter or set it to `null`.
    // guild: Snowflake(Platform.environment['GUILD']!),

    // The `options` parameter allows you to specify additional configuration options for the
    // plugin.
    //
    // Generally you can just omit this parameter and use the defaults, but if you want to allow for
    // a specific behaviour you can include this parameter to change the default settings.
    //
    // In this case, we set the option `logErrors` to `true`, meaning errors that occur in commands
    // will be sent to the logger. If you have also added the `Logging` plugin to your client, these
    // will then be printed to your console.
    // `true` is actually the default for this option and was included here for the sake of example.
    options: CommandsOptions(
      logErrors: true,
    ),
  );
}
