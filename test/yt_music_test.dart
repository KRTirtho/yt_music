import 'package:test/test.dart';
import 'package:yt_music/yt_music.dart';

void main() {
  final client = YTMusicClient();
  group('Search', () {
    final query = 'test';

    test('Search returns a SearchResponse object', () async {
      final response = await client.search.search(query);
      expect(response, isA<SearchResponse>());
    });
  });

  group('Songs', () {
    final id = '5qZQEq_C3vc';

    test('Songs returns a SongEntity object', () async {
      final response = await client.songs.get(id);
      expect(response, isA<SongEntity>());
    });
  });

  group('Streams', () {
    final id = '5qZQEq_C3vc';

    test('Streams returns a StreamEntity object', () async {
      final response = await client.streams.get(id);
      expect(response, isA<StreamEntity>());
    });
  });
}
