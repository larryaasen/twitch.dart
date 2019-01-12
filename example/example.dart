import 'package:twitch/twitch.dart';

/// Example using the New Twitch API helix.
/// https://dev.twitch.tv/docs/api/
void main() async {
  final http = new TwitchHttp(clientId: 'your_client_id');
  final twitch = new Twitch(http);

  // Calls and decodes GET https://api.twitch.tv/kraken/games/top
  final result = await twitch.searchStreams();

  print(
      'The top stream on Twitch is currently: ${result.first.game} with ${result.first.viewers} viewers.');
  http.close();
}
