part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeWikiClicked extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeQueryChanged extends HomeEvent {
  HomeQueryChanged(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}

class HomeQueryEntered extends HomeEvent {
  HomeQueryEntered();

  @override
  List<Object?> get props => [];
}

class NavigatedToHome extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class NavigatedToSettings extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class NavigatedToTrash extends HomeEvent {
  @override
  List<Object?> get props => [];
}
