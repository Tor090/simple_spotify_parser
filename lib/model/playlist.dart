import 'package:simple_spotify_parser/model/song.dart';

class Playlist {
  final String title;
  final String descriptions;
  final String image;
  List<Song> songs;

  Playlist(
      {required this.title,
      required this.descriptions,
      required this.image,
      required this.songs});
}
