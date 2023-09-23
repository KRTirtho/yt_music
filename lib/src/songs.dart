import 'package:yt_music/src/handler.dart';
import 'package:yt_music/src/models/entity/song.dart';

final class SongsApiHandler extends ApiHandler {
  SongsApiHandler({required super.dio});

  Future<SongEntity> get() {}
}
