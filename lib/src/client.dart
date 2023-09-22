import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
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
  ),
);
