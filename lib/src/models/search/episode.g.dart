// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeSearchResult _$EpisodeSearchResultFromJson(Map<String, dynamic> json) =>
    EpisodeSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      published: DateTime.parse(json['published'] as String),
      playlistName: json['playlistName'] as String,
      playlistId: json['playlistId'] as String,
    );

Map<String, dynamic> _$EpisodeSearchResultToJson(
        EpisodeSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'published': instance.published.toIso8601String(),
      'playlistName': instance.playlistName,
      'playlistId': instance.playlistId,
    };

EpisodeSearchResultGroup _$EpisodeSearchResultGroupFromJson(
        Map<String, dynamic> json) =>
    EpisodeSearchResultGroup(
      query: json['query'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodeSearchResultGroupToJson(
        EpisodeSearchResultGroup instance) =>
    <String, dynamic>{
      'query': instance.query,
      'params': instance.params,
      'items': instance.items,
    };
