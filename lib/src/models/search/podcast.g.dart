// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodcastSearchResult _$PodcastSearchResultFromJson(Map<String, dynamic> json) =>
    PodcastSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      publisherName: json['publisherName'] as String,
      publisherId: json['publisherId'] as String,
    );

Map<String, dynamic> _$PodcastSearchResultToJson(
        PodcastSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'publisherName': instance.publisherName,
      'publisherId': instance.publisherId,
    };

PodcastSearchResultGroup _$PodcastSearchResultGroupFromJson(
        Map<String, dynamic> json) =>
    PodcastSearchResultGroup(
      title: json['title'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PodcastSearchResultGroupToJson(
        PodcastSearchResultGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'params': instance.params,
      'items': instance.items,
    };
