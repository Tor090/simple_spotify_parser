import 'package:html/parser.dart' as html;
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';

import '../model/model.dart';
import '../util/helper.dart';

class Service {
  //static const _url = 'https://open.spotify.com/album/1qwlxZTNLe1jq3b0iidlue';

  Future<Playlist> getRequest(String url) async {
    http.Response responce;
    try {
      responce = await http.get(Uri.parse(url));
    } catch (e) {
      rethrow;
    }

    var titleDocument = html.parse(responce.body);

    var metadata = MetadataParser.parse(titleDocument);

    var elem = titleDocument.getElementsByTagName('meta');

    List<String> musicUrl = [];

    for (var e in elem) {
      if (e.attributes.containsValue('music:song')) {
        var content = e.attributes.entries.last.value;
        musicUrl.add(content);
      }
    }

    List<Song> songList = [];

    if (musicUrl.isNotEmpty) {
      for (var music in musicUrl) {
        songList.add(await getSong(music));
      }
    }

    Playlist playlist = Playlist(
        title: metadata.title ?? 'Empty',
        descriptions: metadata.description ?? 'Empty',
        image: metadata.image ?? 'Empty',
        songs: songList);

    return playlist;
  }

  Future<Song> getSong(String musicUrl) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(musicUrl));
    } catch (e) {
      rethrow;
    }

    var document = html.parse(response.body);

    var title = document
        .getElementsByTagName('title')
        .first
        .text
        .replaceAll(' | Spotify', '')
        .replaceAll(' song and lyrics by', '');
    String durationInSeconds = '';
    String album = '';

    var songElem = document.getElementsByTagName('meta');
    for (var e in songElem) {
      if (e.attributes.containsValue('music:duration')) {
        var content = e.attributes.entries.last.value;
        durationInSeconds = content;
      }
      if (e.attributes.containsValue('music:album')) {
        var content = e.attributes.entries.last.value;
        album = content;
      }
    }

    album = await getAlbumName(album);

    String duration = formatedTime(int.parse(durationInSeconds));

    return Song(title: title, album: album, duration: duration);
  }

  Future<String> getAlbumName(String albumUrl) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(albumUrl));
    } catch (e) {
      rethrow;
    }

    var document = html.parse(response.body);

    String title =
        document.getElementsByTagName('title').first.text.split('-').first;
    return title;
  }
}
