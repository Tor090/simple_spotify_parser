part of 'parse_bloc.dart';

abstract class ParseState {}

class InitialParseState extends ParseState {}

class LoadingParseState extends ParseState {}

class ErrorParseState extends ParseState {
  final String error;

  ErrorParseState(this.error);
}

class SuccesParseState extends ParseState {
  Playlist playlist;
  //String data;

  SuccesParseState(this.playlist);
}
