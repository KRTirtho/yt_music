import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/src/models/search/group.dart';
import 'package:yt_music/src/models/search/result.dart';

part 'profile.g.dart';

@JsonSerializable()
final class ProfileSearchResult extends SearchResult {
  final String username;

  ProfileSearchResult({
    required super.id,
    required super.name,
    required super.thumbnail,
    required this.username,
  });

  factory ProfileSearchResult.fromJson(Map<String, dynamic> json) =>
      _$ProfileSearchResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileSearchResultToJson(this);
}

@JsonSerializable()
final class ProfileSearchResultGroup extends SearchResultGroup {
  @override
  List<ProfileSearchResult> get items =>
      super.items as List<ProfileSearchResult>;

  ProfileSearchResultGroup({
    required super.title,
    required super.params,
    required super.items,
  });

  factory ProfileSearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$ProfileSearchResultGroupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileSearchResultGroupToJson(this);
}
