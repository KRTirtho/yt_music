// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSearchResult _$ProfileSearchResultFromJson(Map<String, dynamic> json) =>
    ProfileSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$ProfileSearchResultToJson(
        ProfileSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'username': instance.username,
    };

ProfileSearchResultGroup _$ProfileSearchResultGroupFromJson(
        Map<String, dynamic> json) =>
    ProfileSearchResultGroup(
      title: json['title'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileSearchResultGroupToJson(
        ProfileSearchResultGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'params': instance.params,
      'items': instance.items,
    };
