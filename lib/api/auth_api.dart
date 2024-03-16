import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthAPI {
  AuthAPI._();

  static final customUriScheme = dotenv.env['CUSTOM_URI_SCHEME']!;
  static final redirecUri = dotenv.env['REDIRECT_URI']!;
  static final clientId = dotenv.env['CLIENT_ID']!;
  static final clientSecret = dotenv.env['CLIENT_SECRET']!;

  static Future<void> login() async {
    try {
      SpotifyOAuth2Client client = SpotifyOAuth2Client(
        customUriScheme: customUriScheme,
        redirectUri: redirecUri,
      );
      var authResp =
          await client.requestAuthorization(clientId: clientId, customParams: {
        'show_dialog': 'true'
      }, scopes: [
        'user-read-private',
        'user-read-playback-state',
        'user-modify-playback-state',
        'user-read-currently-playing',
        'user-read-email',
        'playlist-modify-public',
        'playlist-read-private',
        'playlist-modify-private'
      ]);

      var authCode = authResp.code;
      var accessToken = await client.requestAccessToken(
          code: authCode.toString(),
          clientId: clientId,
          clientSecret: clientSecret);

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (accessToken.accessToken != null) {
        await prefs.setString('accessToken', accessToken.accessToken!);
      }
    } catch (e) {
      print('err: $e');
    }
  }
}
