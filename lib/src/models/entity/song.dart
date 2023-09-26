import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/src/extensions/duration.dart';
import 'package:yt_music/src/models/entity/entity.dart';
import 'package:yt_music/src/models/entity/stream.dart';

part 'song.g.dart';

@JsonSerializable()
final class SongEntity extends YouTubeMusicEntity {
  final String artistName;
  final String artistId;
  final String albumName;
  final String albumId;
  final int year;

  @JsonKey(fromJson: ParseDuration.fromString)
  final Duration duration;

  SongEntity({
    required super.id,
    required super.name,
    required super.thumbnail,
    required this.artistName,
    required this.artistId,
    required this.albumName,
    required this.albumId,
    required this.duration,
    required this.year,
  });

  factory SongEntity.fromJson(Map<String, dynamic> json) =>
      _$SongEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SongEntityToJson(this);
}
