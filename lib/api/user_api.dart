import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/album_detail_model.dart';
import '../models/artist_model.dart';
import '../models/playlist_detail_model.dart';
import '../models/playlist_model.dart';
import '../models/playlist_track_list_model.dart';
import '../models/track_list_model.dart';

class UserAPI{
  UserAPI._();

  static final _dio = Dio();

  static final String _baseUrl = dotenv.env['BASE_URL']!;

   static Future<String?> getAccessToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      return prefs.getString('accessToken');
    } catch (e) {
      return '';
    }
  }

  static Future<String?> getUserInfo() async {
    try {
      var accessToken = await getAccessToken();
      final response = await _dio.get(
        '$_baseUrl/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (response.data['id'] != null) {
        await prefs.setString('userId', response.data['id']!);
      }
      return prefs.getString('userId');
    } catch (e) {
      print('error :: $e');
    }
  }

    static Future<List<PlaylistModel>> getUserPlayList() async {
    try {
      var accessToken = await getAccessToken();
      var userId = await getUserInfo();
      final response = await _dio.get(
        '$_baseUrl/users/$userId/playlists',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      final list = response.data['items'] as List;
      return list.map((e) => PlaylistModel.fromMap(e)).toList();
    } catch (e) {
      print('err:: $e');
      return [];
    }
  }

  static createPlaylist(
      {required String playlistName,
      required String playlistDescription,
      required isPlaylistPublic}) async {
    try {
      var accessToken = await getAccessToken();
      var userId = await getUserInfo();

      final response = await _dio.post(
        '$_baseUrl/users/$userId/playlists',
        data: {
          "name": playlistName,
          "description": playlistDescription,
          "public": isPlaylistPublic
        },
        options: Options(
            contentType: Headers.jsonContentType,
            headers: {'Authorization': 'Bearer $accessToken'}),
      );
      await getUserPlayList();
    } catch (e) {
      print('err:: $e');
    }
  }

  static Future<void> addTrackToPlaylist(
      String playlistId, List<String> urisList) async {
    try {
      var accessToken = await getAccessToken();
      final response = await _dio.post(
        '$_baseUrl/playlists/$playlistId/tracks',
        data: {
          "uris": urisList,
        },
        options: Options(
            contentType: Headers.jsonContentType,
            headers: {'Authorization': 'Bearer $accessToken'}),
      );
    } catch (e) {
      print('err :: $e');
    }
  }

  static Future<List<PlaylistModel>> getFeaturePlayList() async {
    try {
      var accessToken = await getAccessToken();
      final response = await _dio.get(
        '$_baseUrl/browse/featured-playlists',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      final list = response.data['playlists']['items'] as List;
      return list.map((e) => PlaylistModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }


  static Future<PlaylistDetailModel?> getPlaylistDetail(
      String playlistId) async {
    try {
      var accessToken = await getAccessToken();

      final response = await _dio.get(
        '$_baseUrl/playlists/$playlistId',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      return PlaylistDetailModel.fromMap(response.data);
    } catch (e) {
      print('err:: $e');
     
    }
  }

  static Future<ArtistModel> getArtistDetail(String artistId) async {
    try {
      var accessToken = await getAccessToken();

      final response = await _dio.get('$_baseUrl/artists/$artistId',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      return ArtistModel.fromMap(response.data);
    } catch (e) {
      print(e);
      return const ArtistModel(id: '', name: '', type: '', images: []);
    }
  }

  static Future<AlbumDetailModel> getAlbumDetail(String albumId) async {
    try {
      var accessToken = await getAccessToken();

      final response = await _dio.get(
        '$_baseUrl/albums/$albumId',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      return AlbumDetailModel.fromMap(response.data);
    } catch (e) {
      print('err:: $e');
      return const AlbumDetailModel(
          id: 'id',
          name: 'name',
          type: 'type',
          tracks: TrackListModel(items: []),
          releaseDate: '',
          images: [],
          artists: []);
    }
  }

}

