import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/models/search/group.dart';
import 'package:yt_music/models/search/result.dart';
import 'package:yt_music/extensions/duration.dart';

part 'song.g.dart';

@JsonSerializable()
final class SongSearchResult extends SearchResult {
  final String artistName;

  final String? artistId;

  @JsonKey(fromJson: ParseDuration.fromString)
  final Duration duration;

  final String albumName;

  final String albumId;

  SongSearchResult({
    required super.id,
    required super.name,
    required super.thumbnail,
    required this.artistName,
    this.artistId,
    required this.duration,
    required this.albumName,
    required this.albumId,
  });

  factory SongSearchResult.fromJson(Map<String, dynamic> json) =>
      _$SongSearchResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SongSearchResultToJson(this);
}

@JsonSerializable()
final class SongSearchResultGroup extends SearchResultGroup {
  @override
  List<SongSearchResult> get items => super.items as List<SongSearchResult>;

  SongSearchResultGroup({
    required super.title,
    required super.params,
    required super.items,
  });

  factory SongSearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$SongSearchResultGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SongSearchResultGroupToJson(this);
}
