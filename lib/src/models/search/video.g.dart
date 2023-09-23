// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoSearchResult _$VideoSearchResultFromJson(Map<String, dynamic> json) =>
    VideoSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      channelName: json['channelName'] as String,
      channelId: json['channelId'] as String,
      views: json['views'] as String,
      duration: ParseDuration.fromString(json['duration'] as String),
    );

Map<String, dynamic> _$VideoSearchResultToJson(VideoSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'channelName': instance.channelName,
      'channelId': instance.channelId,
      'views': instance.views,
      'duration': instance.duration.inMicroseconds,
    };

VideoSearchResultGroup _$VideoSearchResultGroupFromJson(
        Map<String, dynamic> json) =>
    VideoSearchResultGroup(
      query: json['query'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoSearchResultGroupToJson(
        VideoSearchResultGroup instance) =>
    <String, dynamic>{
      'query': instance.query,
      'params': instance.params,
      'items': instance.items,
    };
