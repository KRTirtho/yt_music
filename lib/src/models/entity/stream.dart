import 'package:json_annotation/json_annotation.dart';

part 'stream.g.dart';

@JsonSerializable()
class StreamEntity {
  @JsonKey(fromJson: StreamEntity._parseExpiresIn)
  final Duration expiresIn;
  final List<StreamFormat> formats;
  final List<StreamFormat> adaptiveFormats;

  StreamEntity({
    required this.expiresIn,
    required this.formats,
    required this.adaptiveFormats,
  });

  factory StreamEntity.fromJson(Map<String, dynamic> json) =>
      _$StreamEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StreamEntityToJson(this);

  static Duration _parseExpiresIn(String value) {
    return Duration(seconds: int.parse(value));
  }
}

@JsonSerializable()
class StreamFormat {
  final int itag;
  final int bitrate;
  final int width;
  final int height;
  final int fps;
  final int audioChannels;

  @JsonKey(fromJson: int.parse)
  final int? audioSampleRate;

  @JsonKey(fromJson: DateTime.parse)
  final DateTime lastModified;

  @JsonKey(
    name: 'approxDurationMs',
    fromJson: StreamFormat._parseApproxDurationMs,
  )
  final Duration approxDuration;

  final String mimeType;
  final String quality;
  final String xtags;
  final String qualityLabel;
  final String projectionType;
  final String audioQuality;

  final String? averageBitrate;

  final bool? highReplication;

  @JsonKey(
    name: 'signatureCipher',
    fromJson: StreamFormat._parseSignatureCipher,
  )
  final String url;

  StreamFormat({
    required this.itag,
    required this.bitrate,
    required this.width,
    required this.height,
    required this.fps,
    required this.audioChannels,
    required this.audioSampleRate,
    required this.lastModified,
    required this.approxDuration,
    required this.mimeType,
    required this.quality,
    required this.xtags,
    required this.qualityLabel,
    required this.projectionType,
    required this.audioQuality,
    required this.url,
    this.averageBitrate,
    this.highReplication,
  });

  factory StreamFormat.fromJson(Map<String, dynamic> json) =>
      _$StreamFormatFromJson(json);

  Map<String, dynamic> toJson() => _$StreamFormatToJson(this);

  static Duration _parseApproxDurationMs(String value) {
    final duration = Duration(milliseconds: int.parse(value));
    return duration;
  }

  static String _parseSignatureCipher(String url) {
    return Uri.parse(Uri.decodeComponent(url).split("&url=").last).toString();
  }
}
