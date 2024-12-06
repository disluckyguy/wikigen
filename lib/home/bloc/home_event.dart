part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeWikiClicked extends HomeEvent {}

class HomeQueryEntered extends HomeEvent {
  HomeQueryEntered(this.query);
  final String query;
}

class NavigatedToSettings extends HomeEvent {}

class NavigatedToTrash extends HomeEvent {}
