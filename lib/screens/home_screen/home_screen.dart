import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_spotify_parser/bloc/parse_bloc.dart';
import 'package:simple_spotify_parser/html_service/html_service.dart';
import 'package:simple_spotify_parser/main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.url, Key? key}) : super(key: key);

  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
          create: (context) =>
              ParseBloc(getIt<HtmlService>())..add(StartParseEvent(url)),
          child: BlocBuilder<ParseBloc, ParseState>(
            builder: (context, state) {
              if (state is ErrorParseState) {
                return Center(child: Text(state.error));
              } else if (state is SuccesParseState) {
                final playlist = state.playlist;
                return state.playlist.songs.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              //clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                playlist.image,
                              ),
                            ),
                          ),
                          Text(playlist.title),
                          Text(playlist.descriptions,
                              overflow: TextOverflow.fade),
                          const Divider(),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: playlist.songs.length,
                              itemBuilder: (context, index) {
                                var song = playlist.songs[index];
                                return ListTile(
                                  title: Text(song.title),
                                  trailing: Text(song.duration),
                                  subtitle: Text(song.album),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text('Incorrect url or data error'),
                      );
              } else if (state is LoadingParseState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Icon(Icons.error);
              }
            },
          )),
    );
  }
}
