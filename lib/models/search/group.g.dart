// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultGroup _$SearchResultGroupFromJson(Map<String, dynamic> json) =>
    SearchResultGroup(
      title: json['title'] as String,
      params: json['params'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultGroupToJson(SearchResultGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'params': instance.params,
      'items': instance.items,
    };
