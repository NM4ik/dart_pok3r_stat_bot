import 'package:pok3r_bot/core/db.dart';
import 'package:pok3r_bot/core/discord.dart';
import 'package:pok3r_bot/core/handler.dart';

void main(List<String> arguments) async {
  try {
    /// create database
    await Database().create();

    /// create discord bot
    await Discord().create();
  } catch (e) {
    Handler.catchError(exception: e, methodName: 'main');
    return;
  }
}
