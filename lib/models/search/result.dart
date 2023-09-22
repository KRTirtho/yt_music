import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/models/search/album.dart';
import 'package:yt_music/models/search/artist.dart';
import 'package:yt_music/models/search/episode.dart';
import 'package:yt_music/models/search/playlist.dart';
import 'package:yt_music/models/search/podcast.dart';
import 'package:yt_music/models/search/profile.dart';
import 'package:yt_music/models/search/song.dart';
import 'package:yt_music/models/search/video.dart';

part 'result.g.dart';

@JsonSerializable()
base class SearchResult {
  final String id;
  final String name;
  final String thumbnail;

  SearchResult({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

@JsonSerializable()
final class SearchResponse {
  final SearchResult? topResult;
  final VideoSearchResultGroup? videos;
  final SongSearchResultGroup? songs;
  final AlbumSearchResultGroup? albums;
  final ArtistSearchResultGroup? artists;
  final PlaylistSearchResultGroup? playlists;
  final PodcastSearchResultGroup? podcasts;
  final EpisodeSearchResultGroup? episodes;
  final ProfileSearchResultGroup? profiles;

  SearchResponse({
    this.topResult,
    required this.videos,
    required this.songs,
    required this.albums,
    required this.artists,
    required this.playlists,
    required this.podcasts,
    required this.episodes,
    required this.profiles,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}
