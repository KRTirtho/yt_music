// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamEntity _$StreamEntityFromJson(Map<String, dynamic> json) => StreamEntity(
      expiresIn: StreamEntity._parseExpiresIn(json['expiresIn'] as String),
      formats: (json['formats'] as List<dynamic>)
          .map((e) => StreamFormat.fromJson(e as Map<String, dynamic>))
          .toList(),
      adaptiveFormats: (json['adaptiveFormats'] as List<dynamic>)
          .map((e) => StreamFormat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StreamEntityToJson(StreamEntity instance) =>
    <String, dynamic>{
      'expiresIn': instance.expiresIn.inMicroseconds,
      'formats': instance.formats,
      'adaptiveFormats': instance.adaptiveFormats,
    };

StreamFormat _$StreamFormatFromJson(Map<String, dynamic> json) => StreamFormat(
      itag: json['itag'] as int,
      bitrate: json['bitrate'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      fps: json['fps'] as int,
      audioChannels: json['audioChannels'] as int,
      audioSampleRate: int.parse(json['audioSampleRate'] as String),
      lastModified: DateTime.parse(json['lastModified'] as String),
      approxDuration: StreamFormat._parseApproxDurationMs(
          json['approxDurationMs'] as String),
      mimeType: json['mimeType'] as String,
      quality: json['quality'] as String,
      xtags: json['xtags'] as String,
      qualityLabel: json['qualityLabel'] as String,
      projectionType: json['projectionType'] as String,
      audioQuality: json['audioQuality'] as String,
      url:
          StreamFormat._parseSignatureCipher(json['signatureCipher'] as String),
      averageBitrate: json['averageBitrate'] as String?,
      highReplication: json['highReplication'] as bool?,
    );

Map<String, dynamic> _$StreamFormatToJson(StreamFormat instance) =>
    <String, dynamic>{
      'itag': instance.itag,
      'bitrate': instance.bitrate,
      'width': instance.width,
      'height': instance.height,
      'fps': instance.fps,
      'audioChannels': instance.audioChannels,
      'audioSampleRate': instance.audioSampleRate,
      'lastModified': instance.lastModified.toIso8601String(),
      'approxDurationMs': instance.approxDuration.inMicroseconds,
      'mimeType': instance.mimeType,
      'quality': instance.quality,
      'xtags': instance.xtags,
      'qualityLabel': instance.qualityLabel,
      'projectionType': instance.projectionType,
      'audioQuality': instance.audioQuality,
      'averageBitrate': instance.averageBitrate,
      'highReplication': instance.highReplication,
      'signatureCipher': instance.url,
    };
