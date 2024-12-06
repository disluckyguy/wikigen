part of 'trash_bloc.dart';

sealed class TrashState extends Equatable {
  const TrashState();
  
  @override
  List<Object> get props => [];
}

final class TrashInitial extends TrashState {}
