import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/src/models/search/group.dart';
import 'package:yt_music/src/models/search/result.dart';

part 'episode.g.dart';

@JsonSerializable()
final class EpisodeSearchResult extends SearchResult {
  final DateTime published;
  final String playlistName;
  final String playlistId;

  EpisodeSearchResult({
    required super.id,
    required super.name,
    required super.thumbnail,
    required this.published,
    required this.playlistName,
    required this.playlistId,
  });

  factory EpisodeSearchResult.fromJson(Map<String, dynamic> json) =>
      _$EpisodeSearchResultFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$EpisodeSearchResultToJson(this);
}

@JsonSerializable()
final class EpisodeSearchResultGroup extends SearchResultGroup {
  @override
  List<EpisodeSearchResult> get items =>
      super.items as List<EpisodeSearchResult>;

  EpisodeSearchResultGroup({
    required super.query,
    required super.params,
    required super.items,
  });

  factory EpisodeSearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$EpisodeSearchResultGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EpisodeSearchResultGroupToJson(this);
}
