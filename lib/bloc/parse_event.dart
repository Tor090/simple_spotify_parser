part of 'parse_bloc.dart';

abstract class ParseEvent {}

class StartParseEvent extends ParseEvent {
  final String url;

  StartParseEvent(this.url);
}

class ReloadParseEvent extends ParseEvent {}
