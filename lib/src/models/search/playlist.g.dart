// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistSearchResult _$PlaylistSearchResultFromJson(
        Map<String, dynamic> json) =>
    PlaylistSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      ownerName: json['ownerName'] as String,
      ownerId: json['ownerId'] as String,
      views: json['views'] as String,
    );

Map<String, dynamic> _$PlaylistSearchResultToJson(
        PlaylistSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'ownerName': instance.ownerName,
      'ownerId': instance.ownerId,
      'views': instance.views,
    };

PlaylistSearchResultGroup _$PlaylistSearchResultGroupFromJson(
        Map<String, dynamic> json) =>
    PlaylistSearchResultGroup(
      title: json['title'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistSearchResultGroupToJson(
        PlaylistSearchResultGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'params': instance.params,
      'items': instance.items,
    };
