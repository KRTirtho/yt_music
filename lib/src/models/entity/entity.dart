import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@JsonSerializable()
base class YouTubeMusicEntity {
  final String id;
  final String name;
  final String thumbnail;

  YouTubeMusicEntity({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory YouTubeMusicEntity.fromJson(Map<String, dynamic> json) =>
      _$YouTubeMusicEntityFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeMusicEntityToJson(this);
}
