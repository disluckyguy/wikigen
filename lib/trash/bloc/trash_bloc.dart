import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trash_event.dart';
part 'trash_state.dart';

class TrashBloc extends Bloc<TrashEvent, TrashState> {
  TrashBloc() : super(TrashInitial()) {
    on<TrashEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
