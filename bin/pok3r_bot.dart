import 'package:pok3r_bot/core/db.dart';
import 'package:pok3r_bot/core/discord.dart';
import 'package:pok3r_bot/core/handler.dart';
import 'package:pok3r_bot/service/user_service.dart';

void main(List<String> arguments) async {
  try {
    /// create database
    final db = Database();
    await db.create();

    /// create discord bot
    final discordBot = Discord();
    await discordBot.create();
  } catch (e) {
    Handler.catchError(exception: e);
    return;
  }
}
