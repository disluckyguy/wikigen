part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState(this.wikis);

  final List<Wiki> wikis;
}

final class HomeInitial extends HomeState {
  HomeInitial() : super(List<Wiki>.empty());
}

final class HomeLoading extends HomeState {
  const HomeLoading(super.wikis);
}

final class HomeReady extends HomeState {
  const HomeReady(super.wikis);
}