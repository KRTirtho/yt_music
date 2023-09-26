import 'package:yt_music/src/constants.dart';
import 'package:yt_music/src/handler.dart';
import 'package:yt_music/src/models/entity/stream.dart';

final class StreamsApiHandler extends ApiHandler {
  StreamsApiHandler({required super.dio});

  Future<StreamEntity> get(String id) async {
    final response = await dio.post(
      '/player',
      data: {
        "context": kClientContext,
        "videoId": id,
      },
    );
    return StreamEntity.fromJson(response.data["streamingData"]);
  }
}
