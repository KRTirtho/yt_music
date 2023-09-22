import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/models/search/group.dart';
import 'package:yt_music/models/search/result.dart';

part 'playlist.g.dart';

@JsonSerializable()
final class PlaylistSearchResult extends SearchResult {
  final String ownerName;
  final String ownerId;
  final String views;

  PlaylistSearchResult({
    required super.id,
    required super.name,
    required super.thumbnail,
    required this.ownerName,
    required this.ownerId,
    required this.views,
  });

  factory PlaylistSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PlaylistSearchResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaylistSearchResultToJson(this);
}

@JsonSerializable()
final class PlaylistSearchResultGroup extends SearchResultGroup {
  @override
  List<PlaylistSearchResult> get items =>
      super.items as List<PlaylistSearchResult>;

  PlaylistSearchResultGroup({
    required super.title,
    required super.params,
    required super.items,
  });

  factory PlaylistSearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$PlaylistSearchResultGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaylistSearchResultGroupToJson(this);
}
