import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_spotify_parser/html_service/html_service.dart';

import '../model/playlist.dart';

part 'parse_event.dart';
part 'parse_state.dart';

class ParseBloc extends Bloc<ParseEvent, ParseState> {
  ParseBloc(HtmlService htmlService)
      : _htmlService = htmlService,
        super(InitialParseState()) {
    on<StartParseEvent>((event, emit) => parseLink(event.url));
    on<ReloadParseEvent>((event, emit) => null);
  }

  final HtmlService _htmlService;

  Future<void> parseLink(String url) async {
    emit(LoadingParseState());
    try {
      final data = await _htmlService.getRequest(url);

      emit(SuccesParseState(data));
    } catch (e) {
      emit(ErrorParseState(e.toString()));
    }
  }
}
