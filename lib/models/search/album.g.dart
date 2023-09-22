// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumSearchResult _$AlbumSearchResultFromJson(Map<String, dynamic> json) =>
    AlbumSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      artistName: json['artistName'] as String,
      artistId: json['artistId'] as String?,
      isSingle: json['isSingle'] as bool,
      year: json['year'] as int?,
    );

Map<String, dynamic> _$AlbumSearchResultToJson(AlbumSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'artistName': instance.artistName,
      'artistId': instance.artistId,
      'isSingle': instance.isSingle,
      'year': instance.year,
    };

AlbumSearchResultGroup _$AlbumSearchResultGroupFromJson(
        Map<String, dynamic> json) =>
    AlbumSearchResultGroup(
      title: json['title'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumSearchResultGroupToJson(
        AlbumSearchResultGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'params': instance.params,
      'items': instance.items,
    };
