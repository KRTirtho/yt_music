// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongSearchResult _$SongSearchResultFromJson(Map<String, dynamic> json) =>
    SongSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      artistName: json['artistName'] as String,
      artistId: json['artistId'] as String?,
      duration: ParseDuration.fromString(json['duration'] as String),
      albumName: json['albumName'] as String,
      albumId: json['albumId'] as String,
    );

Map<String, dynamic> _$SongSearchResultToJson(SongSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'artistName': instance.artistName,
      'artistId': instance.artistId,
      'duration': instance.duration.inMicroseconds,
      'albumName': instance.albumName,
      'albumId': instance.albumId,
    };

SongSearchResultGroup _$SongSearchResultGroupFromJson(
        Map<String, dynamic> json) =>
    SongSearchResultGroup(
      query: json['query'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongSearchResultGroupToJson(
        SongSearchResultGroup instance) =>
    <String, dynamic>{
      'query': instance.query,
      'params': instance.params,
      'items': instance.items,
    };
