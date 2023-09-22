import 'package:yt_music/client.dart';
import 'package:yt_music/extensions/duration.dart';
import 'package:yt_music/handler.dart';
import 'package:yt_music/models/search/album.dart';
import 'package:yt_music/models/search/artist.dart';
import 'package:yt_music/models/search/episode.dart';
import 'package:yt_music/models/search/playlist.dart';
import 'package:yt_music/models/search/podcast.dart';
import 'package:yt_music/models/search/profile.dart';
import 'package:yt_music/models/search/result.dart';
import 'package:yt_music/models/search/song.dart';
import 'package:yt_music/models/search/video.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

final class SearchApiHandler extends ApiHandler {
  SearchApiHandler({required super.dio});

  SearchResult? _parseCardShelf(Map<String, dynamic> musicCardShelfRenderer) {
    final titleRun = musicCardShelfRenderer["title"]?["runs"]?.first;
    final videoId =
        titleRun?["navigationEndpoint"]?["watchEndpoint"]?["videoId"];
    final browseId =
        titleRun?["navigationEndpoint"]?["browseEndpoint"]?["browseId"];
    final thumbnail = musicCardShelfRenderer["thumbnail"]
            ?["musicThumbnailRenderer"]["thumbnail"]["thumbnails"]
        .last["url"];
    final subtitleRuns = musicCardShelfRenderer["subtitle"]?["runs"];
    final String subtitle = subtitleRuns?.first?["text"];

    switch (subtitle) {
      case "Video":
        return VideoSearchResult(
          id: videoId,
          name: titleRun?["text"],
          channelId: subtitleRuns?[2]?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          channelName: subtitleRuns?[2]?["text"],
          duration: ParseDuration.fromString(subtitleRuns?.last?["text"]),
          thumbnail: thumbnail,
          views: subtitleRuns?[4]?["text"]?.replaceAll(' views', ''),
        );
      case "Song":
        return SongSearchResult(
          id: videoId,
          name: titleRun?["text"],
          artistId: subtitleRuns?[2]?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          artistName: subtitleRuns?[2]?["text"],
          albumId: subtitleRuns?[4]?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          albumName: subtitleRuns?[4]?["text"],
          duration: ParseDuration.fromString(subtitleRuns?.last?["text"]),
          thumbnail: thumbnail,
        );
      case "Album":
        return AlbumSearchResult(
          id: browseId,
          name: titleRun?["text"],
          artistId: subtitleRuns?.last?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          artistName: subtitleRuns?.last?["text"],
          year: null,
          isSingle: subtitleRuns?.first?["text"] == "Single",
          thumbnail: thumbnail,
        );
      case "Episode":
        return EpisodeSearchResult(
          id: videoId,
          name: titleRun?["text"],
          playlistId: subtitleRuns?.last?["navigationEndpoint"]
              ?["browseEndpoint"]?["browseId"],
          playlistName: subtitleRuns?.last?["text"],
          thumbnail: thumbnail,
          published: DateTime.parse(subtitleRuns?[2]?["text"] ?? ''),
        );
      case "Artist":
        return ArtistSearchResult(
          id: browseId,
          name: titleRun?["text"],
          thumbnail: thumbnail,
          subscribers:
              subtitleRuns?.last?["text"]?.replaceAll(' subscribers', ''),
        );
      default:
        return null;
    }
  }

  SearchResult? _parseShelf(
    Map<String, dynamic> shelfContent,
    String shelfTitle,
  ) {
    final shelfListItem = shelfContent["musicResponsiveListItemRenderer"];
    final shelfColumns = shelfListItem?["flexColumns"];

    final titleRun = shelfColumns
        ?.first?["musicResponsiveListItemFlexColumnRenderer"]?["text"]?["runs"]
        ?.first;
    final columnRun = shelfColumns
        ?.last?["musicResponsiveListItemFlexColumnRenderer"]?["text"]?["runs"];

    final thumbnail = shelfListItem["thumbnail"]?["musicThumbnailRenderer"]
            ?["thumbnail"]?["thumbnails"]
        ?.last?["url"];

    final browseId =
        shelfListItem?["navigationEndpoint"]?["browseEndpoint"]?["browseId"];

    final List? menuItems =
        shelfListItem["menu"]?["menuRenderer"]?["items"] as List?;

    switch (shelfTitle) {
      case "Songs":
        return SongSearchResult(
          thumbnail: thumbnail,
          name: titleRun?["text"],
          id: titleRun?["navigationEndpoint"]?["watchEndpoint"]?["videoId"],
          artistName: columnRun?[2]?["text"],
          artistId: columnRun?[2]?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          duration: ParseDuration.fromString(columnRun?.last?["text"]),
          albumName: columnRun?[4]?["text"],
          albumId: columnRun?[4]?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
        );

      case "Albums":
        {
          return AlbumSearchResult(
            name: titleRun?["text"],
            id: browseId,
            artistName: columnRun?[2]?["text"],
            year: int.tryParse(columnRun?.last?["text"]) ?? 1970,
            artistId: columnRun?[2]?["navigationEndpoint"]?["browseEndpoint"]
                    ?["browseId"] ??
                menuItems?.firstWhereOrNull(
                  (item) =>
                      item["menuNavigationItemRenderer"]?["text"]?["runs"]
                          ?.first?["text"] ==
                      "Go to artist",
                )?["menuNavigationItemRenderer"]?["navigationEndpoint"]
                    ?["browseEndpoint"]?["browseId"],
            isSingle: columnRun?.first?["text"] == "Single",
            thumbnail: thumbnail,
          );
        }

      case "Community playlists":
        return PlaylistSearchResult(
          name: titleRun?["text"],
          id: browseId,
          ownerId: columnRun[2]?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          ownerName: columnRun[2]?["text"],
          views: columnRun.last?["text"]?.replaceAll(' views', ''),
          thumbnail: thumbnail,
        );

      case "Videos":
        return VideoSearchResult(
          id: titleRun?["navigationEndpoint"]?["watchEndpoint"]?["videoId"],
          name: titleRun?["text"],
          thumbnail: thumbnail,
          channelId: columnRun[2]?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          channelName: columnRun[2]?["text"],
          views: columnRun[4]?["text"]?.replaceAll(' views', ''),
          duration: ParseDuration.fromString(columnRun?.last?["text"]),
        );

      case "Artists":
        return ArtistSearchResult(
          id: browseId,
          name: titleRun?["text"],
          thumbnail: thumbnail,
          subscribers: columnRun.last?["text"]?.replaceAll(' subscribers', ''),
        );

      case "Episodes":
        return EpisodeSearchResult(
          name: titleRun?["text"],
          id: titleRun?["navigationEndpoint"]?["browseEndpoint"]?["browseId"],
          thumbnail: thumbnail,
          playlistName: columnRun.last?["text"],
          playlistId: columnRun.last?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          published: DateTime.parse(columnRun[2]?["text"] ?? ''),
        );

      case "Podcasts":
        return PodcastSearchResult(
          name: titleRun?["text"],
          id: browseId,
          publisherName: columnRun.last?["text"],
          publisherId: columnRun.last?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          thumbnail: thumbnail,
        );

      case "Profiles":
        return ProfileSearchResult(
          name: titleRun?["text"],
          id: browseId,
          username: columnRun.last?["text"],
          thumbnail: thumbnail,
        );

      default:
        return null;
    }
  }

  SearchResponse _parseResponse(Map<String, dynamic> data) {
    final List contents = data["contents"]?["tabbedSearchResultsRenderer"]
                    ?["tabs"]
                ?.first?["tabRenderer"]?["content"]?["sectionListRenderer"]
            ?["contents"] ??
        [];

    SearchResult? topResult = null;
    VideoSearchResultGroup? videosGroup;
    SongSearchResultGroup? songsGroup;
    AlbumSearchResultGroup? albumsGroup;
    ArtistSearchResultGroup? artistsGroup;
    PlaylistSearchResultGroup? playlistsGroup;
    PodcastSearchResultGroup? podcastsGroup;
    EpisodeSearchResultGroup? episodesGroup;
    ProfileSearchResultGroup? profilesGroup;

    for (final content in contents) {
      final header = content?["musicCardShelfRenderer"]?["header"]
                  ?["musicCardShelfHeaderBasicRenderer"]?["title"]?["runs"]
              ?.first?["text"] ??
          content?["musicShelfRenderer"]?["title"]?["runs"]?.first?["text"];
      final isTopResult = header == "Top result";

      if (isTopResult) {
        topResult = content["musicCardShelfRenderer"] != null
            ? _parseCardShelf(content["musicCardShelfRenderer"])
            : _parseShelf(
                content?["musicShelfRenderer"],
                content?["musicShelfRenderer"]?["contents"]
                    ?.first?["musicResponsiveListItemRenderer"]?["flexColumns"]
                        ?[1]?["musicResponsiveListItemFlexColumnRenderer"]
                        ?["text"]?["runs"]
                    ?.first?["text"],
              );
        continue;
      }

      final String shelfTitle =
          content["musicShelfRenderer"]?["title"]?["runs"]?.first?["text"];
      final List shelfContents =
          content["musicShelfRenderer"]?["contents"] ?? [];

      final params = content["musicShelfRenderer"]?["bottomEndpoint"]
          ?["searchEndpoint"]?["params"];

      final shelfParsedItem =
          shelfContents.map((s) => _parseShelf(s, shelfTitle)).toList();

      switch (shelfTitle) {
        case "Videos":
          {
            videosGroup = VideoSearchResultGroup(
              title: shelfTitle,
              params: params,
              items: shelfParsedItem.whereType<VideoSearchResult>().toList(),
            );
            break;
          }
        case "Songs":
          {
            songsGroup = SongSearchResultGroup(
              title: shelfTitle,
              params: params,
              items: shelfParsedItem.whereType<SongSearchResult>().toList(),
            );
            break;
          }
        case "Albums":
          {
            albumsGroup = AlbumSearchResultGroup(
              title: shelfTitle,
              params: params,
              items: shelfParsedItem.whereType<AlbumSearchResult>().toList(),
            );
            break;
          }
        case "Artists":
          {
            artistsGroup = ArtistSearchResultGroup(
              title: shelfTitle,
              params: params,
              items: shelfParsedItem.whereType<ArtistSearchResult>().toList(),
            );
            break;
          }
        case "Community playlists":
          {
            playlistsGroup = PlaylistSearchResultGroup(
              title: shelfTitle,
              params: params,
              items: shelfParsedItem.whereType<PlaylistSearchResult>().toList(),
            );
            break;
          }
        case "Podcasts":
          {
            podcastsGroup = PodcastSearchResultGroup(
              title: shelfTitle,
              params: params,
              items: shelfParsedItem.whereType<PodcastSearchResult>().toList(),
            );
            break;
          }
        case "Episodes":
          {
            episodesGroup = EpisodeSearchResultGroup(
              title: shelfTitle,
              params: params,
              items: shelfParsedItem.whereType<EpisodeSearchResult>().toList(),
            );
            break;
          }
        case "Profiles":
          {
            profilesGroup = ProfileSearchResultGroup(
              title: shelfTitle,
              params: params,
              items: shelfParsedItem.whereType<ProfileSearchResult>().toList(),
            );
            break;
          }
      }
    }

    return SearchResponse(
      topResult: topResult,
      videos: videosGroup,
      songs: songsGroup,
      albums: albumsGroup,
      artists: artistsGroup,
      playlists: playlistsGroup,
      podcasts: podcastsGroup,
      episodes: episodesGroup,
      profiles: profilesGroup,
    );
  }

  Future<SearchResponse> search(String query) async {
    final response = await dio.post(
      '/search',
      data: {
        "context": {
          "client": {
            "clientName": "WEB_REMIX",
            "clientVersion": "1.20230724.00.00"
          }
        },
        "query": query
      },
    );

    final data = _parseResponse(response.data);
    return data;
  }
}
