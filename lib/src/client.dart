import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yt_music/src/search.dart';
import 'package:yt_music/src/songs.dart';
import 'package:yt_music/src/streams.dart';

class YTMusicClient {
  static final defaultBaseOptions = BaseOptions(
    baseUrl: 'https://youtubei.googleapis.com/youtubei/v1',
    headers: {
      'Content-Type': 'application/json',
      'X-Goog-Api-Format-Version': 'v1',
      'X-YouTube-Client-Name': '1',
      'X-YouTube-Client-Version': '2.20230728.00.00',
      'Referer': 'https://music.youtube.com/'
    },
    queryParameters: {
      'key': 'AIzaSyC9XL3ZjWddXya6X74dJoCTL-WEYFDNX30',
      'alt': 'json',
    },
    method: 'POST',
    responseType: ResponseType.json,
  );

  final Dio _dio;
  late final SearchApiHandler search;
  late final SongsApiHandler songs;
  late final StreamsApiHandler streams;

  YTMusicClient({BaseOptions? baseOptions})
      : _dio = Dio(baseOptions ?? defaultBaseOptions) {
    search = SearchApiHandler(dio: _dio);
    songs = SongsApiHandler(dio: _dio);
    streams = StreamsApiHandler(dio: _dio);
  }
}
