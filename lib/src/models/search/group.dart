import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/src/models/search/result.dart';

part 'group.g.dart';

@JsonSerializable()
base class SearchResultGroup {
  final String query;
  final String params;
  final List<SearchResult> items;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late Dio dio;

  SearchResultGroup({
    required this.query,
    required this.params,
    required this.items,
  });

  factory SearchResultGroup.fromJson(Map<String, dynamic> json) =>
      _$SearchResultGroupFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultGroupToJson(this);

  SearchResultGroup copyWith({
    String? query,
    String? params,
    List<SearchResult>? items,
  }) {
    return SearchResultGroup(
      query: query ?? this.query,
      params: params ?? this.params,
      items: items ?? this.items,
    );
  }
}
