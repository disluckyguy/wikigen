part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState(this.wikis, this.query);

  final List<Wiki> wikis;
  final String query;

  @override
  List<Object?> get props => [wikis, query];
}

final class HomeInitial extends HomeState {
  const HomeInitial(super.wikis, super.query);
  @override
  List<Object?> get props => [wikis, query];
}

final class HomeLoading extends HomeState {
  const HomeLoading(super.wikis, super.query);

  @override
  List<Object?> get props => [wikis];
}

final class HomeReady extends HomeState {
  const HomeReady(super.wikis, super.query, this.currentWiki);
  final Wiki currentWiki;

  @override
  List<Object?> get props => [wikis, query, currentWiki];
}
