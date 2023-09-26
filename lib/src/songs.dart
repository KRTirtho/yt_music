import 'package:yt_music/src/constants.dart';
import 'package:yt_music/src/extensions/duration.dart';
import 'package:yt_music/src/handler.dart';
import 'package:yt_music/src/models/entity/song.dart';

final class SongsApiHandler extends ApiHandler {
  SongsApiHandler({required super.dio});

  Future<SongEntity> get(String id) async {
    final response = await dio.post(
      '/next',
      data: {
        "context": kClientContext,
        "videoId": id,
      },
    );

    final songRun = response
        .data?["contents"]?["singleColumnMusicWatchNextResultsRenderer"]
            ?["tabbedRenderer"]?["watchNextTabbedResultsRenderer"]?["tabs"]
        ?.first["tabRenderer"]?["content"]?["musicQueueRenderer"]?["content"]
            ?["playlistPanelRenderer"]?["contents"]
        ?.first?["playlistPanelVideoRenderer"];

    final subtitleRun = songRun?["longBylineText"]?["runs"];

    return SongEntity(
      id: id,
      name: songRun?["title"]?["runs"]?.first["text"],
      artistName: subtitleRun?.first["text"],
      artistId: subtitleRun?.first["navigationEndpoint"]?["browseEndpoint"]
          ?["browseId"],
      albumName: subtitleRun?[2]?["text"],
      albumId: subtitleRun?[2]?["navigationEndpoint"]?["browseEndpoint"]
          ?["browseId"],
      duration: ParseDuration.fromString(
        songRun?["lengthText"]?["runs"]?.first["text"],
      ),
      year: int.parse(subtitleRun?.last?["text"]),
      thumbnail: songRun?["thumbnail"]?["thumbnails"]?.last?["url"],
    );
  }
}
