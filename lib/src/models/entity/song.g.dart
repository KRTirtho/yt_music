// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongEntity _$SongEntityFromJson(Map<String, dynamic> json) => SongEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      artistName: json['artistName'] as String,
      artistId: json['artistId'] as String,
      albumName: json['albumName'] as String,
      albumId: json['albumId'] as String,
      duration: ParseDuration.fromString(json['duration'] as String),
      stream: StreamEntity.fromJson(json['stream'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SongEntityToJson(SongEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'artistName': instance.artistName,
      'artistId': instance.artistId,
      'albumName': instance.albumName,
      'albumId': instance.albumId,
      'duration': instance.duration.inMicroseconds,
      'stream': instance.stream,
    };
