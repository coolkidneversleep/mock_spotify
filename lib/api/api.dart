import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mockspotify/models/album_detail_model.dart';
import 'package:mockspotify/models/album_model.dart';
import 'package:mockspotify/models/artist_model.dart';
import 'package:mockspotify/models/image_model.dart';
import 'package:mockspotify/models/playlist_model.dart';
import 'package:mockspotify/models/playlist_track_list_model.dart';
import 'package:mockspotify/models/track_list_model.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/playlist_detail_model.dart';

class API {
  API._();

  static final _dio = Dio();

  static const String _baseUrl = 'https://api.spotify.com/v1';
  static const data = {
    'grant_type': "client_credentials",
    'client_id': "b4c93b067ded42e09c4eef269ecb7899",
    'client_secret': "932d6d6393e34c81ae727633fe3495ac",
  };

  static Future<String?> getAccessToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      return prefs.getString('accessToken');
    } catch (e) {
      return '';
    }
  }

  
  



  
  

  

  

  

  static Future<List<AlbumModel>> getSearch(String keyWord) async {
    try {
      var accessToken = await getAccessToken();

      final response = await _dio.get('$_baseUrl/search',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          queryParameters: {
            'q': keyWord,
            'type': "album",
          });
      print(response.data);
      final list = response.data['albums']['items'] as List;
      print(list.map((e) => AlbumModel.fromMap(e)).toList());

      return list.map((e) => AlbumModel.fromMap(e)).toList();
    } catch (e) {
      print('err:: $e');
      return [];
    }
  }
}


//  queryParameters: {
//             'limit': 10,
//             'seed_artist': "4NHQUGzhtTLFvgF5SZesLK",
//             'seed_genre': "classical",
//             'seed_tracks': "0c6xIDDpzE81m2q797ordA",
//           }