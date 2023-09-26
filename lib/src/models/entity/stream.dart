import 'package:json_annotation/json_annotation.dart';

part 'stream.g.dart';

@JsonSerializable()
class StreamEntity {
  @JsonKey(name: 'expiresInSeconds', fromJson: StreamEntity._parseExpiresIn)
  final Duration expiresIn;
  final List<StreamFormat> formats;
  final List<AdaptiveStreamFormat> adaptiveFormats;

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
  final int? width;
  final int? height;
  final int? fps;

  final int? audioChannels;

  @JsonKey(fromJson: StreamFormat._parseNullableStringInt)
  final int? audioSampleRate;

  @JsonKey(fromJson: StreamFormat._parseStingTimeStamp)
  final DateTime lastModified;

  @JsonKey(
    name: 'approxDurationMs',
    fromJson: StreamFormat._parseApproxDurationMs,
  )
  final Duration approxDuration;

  final String mimeType;
  final String quality;
  final String? xtags;
  final String? qualityLabel;
  final String projectionType;
  final String? audioQuality;

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
  });

  factory StreamFormat.fromJson(Map<String, dynamic> json) =>
      _$StreamFormatFromJson(json);

  Map<String, dynamic> toJson() => _$StreamFormatToJson(this);

  static Duration _parseApproxDurationMs(String value) =>
      Duration(milliseconds: int.parse(value));

  static String _decipherSignature(String a) {
    final EP = (
      O9: (List<String> a, int b) {
        var c = a[0];
        a[0] = a[b % a.length];
        a[b % a.length] = c;
      },
      IP: (List<String> a, int b) {
        a.removeRange(0, b);
      },
      de: (List<String> a) {
        a = a.reversed.toList();
      }
    );
    var chars = a.split('');
    EP.de(chars);
    EP.O9(chars, 10);
    EP.IP(chars, 1);
    EP.O9(chars, 48);
    EP.O9(chars, 62);
    EP.IP(chars, 2);
    EP.O9(chars, 25);
    EP.de(chars);
    EP.IP(chars, 1);
    return chars.join('');
  }

  static String _parseSignatureCipher(String signatureCipher) {
    final queryStrings = Map.fromEntries(
      signatureCipher.split("&").map((e) {
        final split = e.split("=");
        return MapEntry(split.first, split.last);
      }),
    );

    Uri url = Uri.parse(Uri.decodeComponent(queryStrings["url"]!));
    url = url.replace(
      queryParameters: {
        ...url.queryParameters,
        queryStrings["sp"]!: _decipherSignature(queryStrings["s"]!)
      },
    );

    return url.toString();
  }

  static DateTime _parseStingTimeStamp(d) =>
      DateTime.fromMicrosecondsSinceEpoch(int.parse(d));
  static int? _parseNullableStringInt(d) => d == null ? null : int.parse(d);
}

@JsonSerializable()
class StreamByteRange {
  @JsonKey(fromJson: int.parse)
  final int start;
  @JsonKey(fromJson: int.parse)
  final int end;

  StreamByteRange({
    required this.start,
    required this.end,
  });

  factory StreamByteRange.fromJson(Map<String, dynamic> json) =>
      _$StreamByteRangeFromJson(json);

  Map<String, dynamic> toJson() => _$StreamByteRangeToJson(this);
}

@JsonSerializable()
class AdaptiveStreamFormat extends StreamFormat {
  final StreamByteRange initRange;

  final StreamByteRange indexRange;

  final String contentLength;

  final int averageBitrate;

  final bool? highReplication;

  AdaptiveStreamFormat({
    required super.itag,
    required super.bitrate,
    required super.width,
    required super.height,
    required super.fps,
    required super.audioChannels,
    required super.audioSampleRate,
    required super.lastModified,
    required super.approxDuration,
    required super.mimeType,
    required super.quality,
    required super.xtags,
    required super.qualityLabel,
    required super.projectionType,
    required super.audioQuality,
    required super.url,
    required this.contentLength,
    required this.initRange,
    required this.indexRange,
    required this.averageBitrate,
    required this.highReplication,
  });

  factory AdaptiveStreamFormat.fromJson(Map<String, dynamic> json) =>
      _$AdaptiveStreamFormatFromJson(json);

  Map<String, dynamic> toJson() => _$AdaptiveStreamFormatToJson(this);
}
