import 'package:bloc/bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';
import 'package:wikigen/models/wiki.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      on<HomeQueryEntered>(_onQueryEntered);
    });
  }

  void _onQueryEntered(
      HomeQueryEntered event, Emitter<HomeState> emit) async {
    emit(HomeLoading(state.wikis));
  }
}
