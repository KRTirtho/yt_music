// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistSearchResult _$ArtistSearchResultFromJson(Map<String, dynamic> json) =>
    ArtistSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      subscribers: json['subscribers'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$ArtistSearchResultToJson(ArtistSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'subscribers': instance.subscribers,
    };

ArtistSearchResultGroup _$ArtistSearchResultGroupFromJson(
        Map<String, dynamic> json) =>
    ArtistSearchResultGroup(
      query: json['query'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistSearchResultGroupToJson(
        ArtistSearchResultGroup instance) =>
    <String, dynamic>{
      'query': instance.query,
      'params': instance.params,
      'items': instance.items,
    };
