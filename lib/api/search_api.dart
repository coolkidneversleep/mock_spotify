import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockspotify/api/user_api.dart';

import '../models/album_model.dart';

class SearchAPI {
  SearchAPI._();
  static final _dio = Dio();

  static final String _baseUrl = dotenv.env['BASE_URL']!;

  static Future<List<AlbumModel>> getSearch(String keyWord) async {
    try {
      var accessToken = await UserAPI.getAccessToken();

      final response = await _dio.get('$_baseUrl/search',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          queryParameters: {
            'q': keyWord,
            'type': "album",
          });

      final list = response.data['albums']['items'] as List;

      return list.map((e) => AlbumModel.fromMap(e)).toList();
    } catch (e) {
      print('err:: $e');
      return [];
    }
  }
}
