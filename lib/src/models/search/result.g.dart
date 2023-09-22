// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
    };

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      topResult: json['topResult'] == null
          ? null
          : SearchResult.fromJson(json['topResult'] as Map<String, dynamic>),
      videos: json['videos'] == null
          ? null
          : VideoSearchResultGroup.fromJson(
              json['videos'] as Map<String, dynamic>),
      songs: json['songs'] == null
          ? null
          : SongSearchResultGroup.fromJson(
              json['songs'] as Map<String, dynamic>),
      albums: json['albums'] == null
          ? null
          : AlbumSearchResultGroup.fromJson(
              json['albums'] as Map<String, dynamic>),
      artists: json['artists'] == null
          ? null
          : ArtistSearchResultGroup.fromJson(
              json['artists'] as Map<String, dynamic>),
      playlists: json['playlists'] == null
          ? null
          : PlaylistSearchResultGroup.fromJson(
              json['playlists'] as Map<String, dynamic>),
      podcasts: json['podcasts'] == null
          ? null
          : PodcastSearchResultGroup.fromJson(
              json['podcasts'] as Map<String, dynamic>),
      episodes: json['episodes'] == null
          ? null
          : EpisodeSearchResultGroup.fromJson(
              json['episodes'] as Map<String, dynamic>),
      profiles: json['profiles'] == null
          ? null
          : ProfileSearchResultGroup.fromJson(
              json['profiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'topResult': instance.topResult,
      'videos': instance.videos,
      'songs': instance.songs,
      'albums': instance.albums,
      'artists': instance.artists,
      'playlists': instance.playlists,
      'podcasts': instance.podcasts,
      'episodes': instance.episodes,
      'profiles': instance.profiles,
    };
