import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/src/extensions/duration.dart';
import 'package:yt_music/src/models/search/group.dart';
import 'package:yt_music/src/models/search/result.dart';

part 'video.g.dart';

@JsonSerializable()
final class VideoSearchResult extends SearchResult {
  final String channelName;
  final String channelId;
  final String views;
  @JsonKey(fromJson: ParseDuration.fromString)
  final Duration duration;

  VideoSearchResult({
    required super.id,
    required super.name,
    required super.thumbnail,
    required this.channelName,
    required this.channelId,
    required this.views,
    required this.duration,
  });

  factory VideoSearchResult.fromJson(Map<String, dynamic> json) =>
      _$VideoSearchResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoSearchResultToJson(this);
}

@JsonSerializable()
final class VideoSearchResultGroup extends SearchResultGroup {
  @override
  List<VideoSearchResult> get items => super.items as List<VideoSearchResult>;

  VideoSearchResultGroup({
    required super.title,
    required super.params,
    required super.items,
  });

  factory VideoSearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$VideoSearchResultGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoSearchResultGroupToJson(this);
}
