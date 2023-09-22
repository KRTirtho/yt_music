import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/models/search/group.dart';
import 'package:yt_music/models/search/result.dart';

part 'podcast.g.dart';

@JsonSerializable()
final class PodcastSearchResult extends SearchResult {
  final String publisherName;
  final String publisherId;

  PodcastSearchResult({
    required super.id,
    required super.name,
    required super.thumbnail,
    required this.publisherName,
    required this.publisherId,
  });

  factory PodcastSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PodcastSearchResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PodcastSearchResultToJson(this);
}

@JsonSerializable()
final class PodcastSearchResultGroup extends SearchResultGroup {
  @override
  List<PodcastSearchResult> get items =>
      super.items as List<PodcastSearchResult>;

  PodcastSearchResultGroup({
    required super.title,
    required super.params,
    required super.items,
  });

  factory PodcastSearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$PodcastSearchResultGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PodcastSearchResultGroupToJson(this);
}
