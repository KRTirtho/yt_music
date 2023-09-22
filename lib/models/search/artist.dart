import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/models/search/group.dart';
import 'package:yt_music/models/search/result.dart';

part 'artist.g.dart';

@JsonSerializable()
final class ArtistSearchResult extends SearchResult {
  final String subscribers;

  ArtistSearchResult({
    required super.id,
    required super.name,
    required this.subscribers,
    required super.thumbnail,
  });

  factory ArtistSearchResult.fromJson(Map<String, dynamic> json) =>
      _$ArtistSearchResultFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ArtistSearchResultToJson(this);
}

@JsonSerializable()
final class ArtistSearchResultGroup extends SearchResultGroup {
  @override
  List<ArtistSearchResult> get items => super.items as List<ArtistSearchResult>;

  ArtistSearchResultGroup({
    required super.title,
    required super.params,
    required super.items,
  });

  factory ArtistSearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$ArtistSearchResultGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ArtistSearchResultGroupToJson(this);
}
