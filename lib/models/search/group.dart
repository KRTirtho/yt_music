import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/mixins/search.dart';
import 'package:yt_music/models/search/result.dart';

part 'group.g.dart';

@JsonSerializable()
base class SearchResultGroup with ExpandSearchResultGroup {
  final String title;
  final String params;
  final List<SearchResult> items;

  SearchResultGroup({
    required this.title,
    required this.params,
    required this.items,
  });

  factory SearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$SearchResultGroupFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultGroupToJson(this);
}
