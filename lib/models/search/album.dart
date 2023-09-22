import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/models/search/group.dart';
import 'package:yt_music/models/search/result.dart';

part 'album.g.dart';

@JsonSerializable()
final class AlbumSearchResult extends SearchResult {
  final String artistName;
  final String? artistId;
  final bool isSingle;
  final int? year;

  AlbumSearchResult({
    required super.id,
    required super.name,
    required super.thumbnail,
    required this.artistName,
    this.artistId,
    required this.isSingle,
    this.year,
  });

  factory AlbumSearchResult.fromJson(Map<String, dynamic> json) =>
      _$AlbumSearchResultFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AlbumSearchResultToJson(this);
}

@JsonSerializable()
final class AlbumSearchResultGroup extends SearchResultGroup {
  @override
  List<AlbumSearchResult> get items => super.items as List<AlbumSearchResult>;

  AlbumSearchResultGroup({
    required super.title,
    required super.params,
    required super.items,
  });

  factory AlbumSearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$AlbumSearchResultGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlbumSearchResultGroupToJson(this);
}
