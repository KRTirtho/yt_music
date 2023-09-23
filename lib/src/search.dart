import 'dart:convert';

import 'package:yt_music/src/client.dart';
import 'package:yt_music/src/extensions/duration.dart';
import 'package:yt_music/src/handler.dart';
import 'package:yt_music/src/models/search/album.dart';
import 'package:yt_music/src/models/search/artist.dart';
import 'package:yt_music/src/models/search/episode.dart';
import 'package:yt_music/src/models/search/group.dart';
import 'package:yt_music/src/models/search/playlist.dart';
import 'package:yt_music/src/models/search/podcast.dart';
import 'package:yt_music/src/models/search/profile.dart';
import 'package:yt_music/src/models/search/result.dart';
import 'package:yt_music/src/models/search/song.dart';
import 'package:yt_music/src/models/search/video.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

enum ShelfTitle {
  videos("Videos"),
  songs("Songs"),
  albums("Albums"),
  artists("Artists"),
  playlists("Community playlists"),
  podcasts("Podcasts"),
  episodes("Episodes"),
  profiles("Profiles");

  final String original;
  const ShelfTitle(this.original);

  static ShelfTitle fromString(String title) {
    return ShelfTitle.values.firstWhere((e) => e.original == title);
  }
}

enum SubTitle {
  video("Video"),
  song("Song"),
  album("Album"),
  artist("Artist"),
  playlist("Playlist"),
  podcast("Podcast"),
  episode("Episode"),
  profile("Profile");

  final String original;
  const SubTitle(this.original);

  static SubTitle fromString(String title) {
    return SubTitle.values.firstWhere((e) => e.original == title);
  }
}

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
    final subtitle = SubTitle.fromString(subtitleRuns?.first?["text"]);

    switch (subtitle) {
      case SubTitle.video:
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
      case SubTitle.song:
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
      case SubTitle.album:
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
      case SubTitle.episode:
        return EpisodeSearchResult(
          id: videoId,
          name: titleRun?["text"],
          playlistId: subtitleRuns?.last?["navigationEndpoint"]
              ?["browseEndpoint"]?["browseId"],
          playlistName: subtitleRuns?.last?["text"],
          thumbnail: thumbnail,
          published: DateTime.parse(subtitleRuns?[2]?["text"] ?? ''),
        );
      case SubTitle.artist:
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
    ShelfTitle shelfTitle,
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
      case ShelfTitle.songs:
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

      case ShelfTitle.albums:
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

      case ShelfTitle.playlists:
        return PlaylistSearchResult(
          name: titleRun?["text"],
          id: browseId,
          ownerId: columnRun[2]?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          ownerName: columnRun[2]?["text"],
          views: columnRun.last?["text"]?.replaceAll(' views', ''),
          thumbnail: thumbnail,
        );

      case ShelfTitle.videos:
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

      case ShelfTitle.artists:
        return ArtistSearchResult(
          id: browseId,
          name: titleRun?["text"],
          thumbnail: thumbnail,
          subscribers: columnRun.last?["text"]?.replaceAll(' subscribers', ''),
        );

      case ShelfTitle.episodes:
        return EpisodeSearchResult(
          name: titleRun?["text"],
          id: titleRun?["navigationEndpoint"]?["browseEndpoint"]?["browseId"],
          thumbnail: thumbnail,
          playlistName: columnRun.last?["text"],
          playlistId: columnRun.last?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          published: DateTime.parse(columnRun[2]?["text"] ?? ''),
        );

      case ShelfTitle.podcasts:
        return PodcastSearchResult(
          name: titleRun?["text"],
          id: browseId,
          publisherName: columnRun.last?["text"],
          publisherId: columnRun.last?["navigationEndpoint"]?["browseEndpoint"]
              ?["browseId"],
          thumbnail: thumbnail,
        );

      case ShelfTitle.profiles:
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

  SearchResponse _parseResponse(Map<String, dynamic> data, String query) {
    final List contents = data["contents"]?["tabbedSearchResultsRenderer"]
                    ?["tabs"]
                ?.first?["tabRenderer"]?["content"]?["sectionListRenderer"]
            ?["contents"] ??
        [];

    SearchResult? topResult;
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

      final shelfParsedItem = shelfContents
          .map((s) => _parseShelf(s, ShelfTitle.fromString(shelfTitle)))
          .toList();

      switch (shelfTitle) {
        case "Videos":
          {
            videosGroup = VideoSearchResultGroup(
              query: query,
              params: params,
              items: shelfParsedItem.whereType<VideoSearchResult>().toList(),
            );
            break;
          }
        case "Songs":
          {
            songsGroup = SongSearchResultGroup(
              query: query,
              params: params,
              items: shelfParsedItem.whereType<SongSearchResult>().toList(),
            );
            break;
          }
        case "Albums":
          {
            albumsGroup = AlbumSearchResultGroup(
              query: query,
              params: params,
              items: shelfParsedItem.whereType<AlbumSearchResult>().toList(),
            );
            break;
          }
        case "Artists":
          {
            artistsGroup = ArtistSearchResultGroup(
              query: query,
              params: params,
              items: shelfParsedItem.whereType<ArtistSearchResult>().toList(),
            );
            break;
          }
        case "Community playlists":
          {
            playlistsGroup = PlaylistSearchResultGroup(
              query: query,
              params: params,
              items: shelfParsedItem.whereType<PlaylistSearchResult>().toList(),
            );
            break;
          }
        case "Podcasts":
          {
            podcastsGroup = PodcastSearchResultGroup(
              query: query,
              params: params,
              items: shelfParsedItem.whereType<PodcastSearchResult>().toList(),
            );
            break;
          }
        case "Episodes":
          {
            episodesGroup = EpisodeSearchResultGroup(
              query: query,
              params: params,
              items: shelfParsedItem.whereType<EpisodeSearchResult>().toList(),
            );
            break;
          }
        case "Profiles":
          {
            profilesGroup = ProfileSearchResultGroup(
              query: query,
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

    final data = _parseResponse(response.data, query);
    return data;
  }

  Future<SearchResultGroup> expandSearch(SearchResultGroup group) async {
    final SearchResultGroup(:params, :query) = group;

    final response = await dio.post(
      '/search',
      data: {
        "context": {
          "client": {
            "clientName": "WEB_REMIX",
            "clientVersion": "1.20230724.00.00"
          }
        },
        "params": params,
        "query": query
      },
    );

    final content = response
        .data?['contents']?['tabbedSearchResultsRenderer']?['tabs']
        ?.first?['tabRenderer']?['content']?['sectionListRenderer']?['contents']
        ?.first['musicShelfRenderer'];

    final shelfTitle =
        ShelfTitle.fromString(content?['title']?['runs']?.first?['text']);

    switch (shelfTitle) {
      case ShelfTitle.songs:
      case ShelfTitle.videos:
      case ShelfTitle.podcasts:
      case ShelfTitle.episodes:
      case ShelfTitle.playlists:
        // Manually adding the title to the first item of flexColumn's subtitle
        // to allow parsing of the content correctly
        content?['contents']?.forEach((shelfContent) {
          final List? columnRun =
              shelfContent['musicResponsiveListItemRenderer']?['flexColumns']
                      ?.last?['musicResponsiveListItemFlexColumnRenderer']
                  ?['text']?['runs'] as List?;

          columnRun?.insertAll(0, [
            {"text": shelfTitle.original},
            {"text": "."},
          ]);
        });
        break;
      default:
        break;
    }

    final results = content?['contents']
        ?.map((s) => _parseShelf(s, shelfTitle))
        .whereType<SearchResult>()
        .toList();

    return group.copyWith(items: results);
  }
}
