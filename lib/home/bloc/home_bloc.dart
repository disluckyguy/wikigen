import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:wiki_repository/wiki_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._wikiRepositoy) : super(HomeInitial(List.empty(), "")) {
    on<HomeEvent>((event, emit) {
      on<HomeQueryEntered>(_onQueryEntered);
      on<HomeQueryChanged>(_onQueryChanged);
      on<NavigatedToHome>(_onNavigatedToHome);
    });
  }

  final WikiRepositoy _wikiRepositoy;

  Future<void> _onQueryEntered(
      HomeQueryEntered event, Emitter<HomeState> emit) async {
    emit(HomeLoading(state.wikis, state.query));

    final wiki = await _wikiRepositoy.get_wiki(state.query);
    emit(HomeReady(state.wikis, state.query, wiki));
  }

  void _onQueryChanged(HomeQueryChanged event, Emitter<HomeState> emit) {
    emit(HomeInitial(state.wikis, event.query));
  }

  void _onNavigatedToHome(NavigatedToHome event, Emitter<HomeState> emit) {
    emit(HomeInitial(state.wikis, ""));
  }
}
