part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchMoviesEvent extends MoviesEvent {}
class AddItemEvent extends MoviesEvent {
  final String item;
  const AddItemEvent({required this.item});
}
class UpdateItemEvent extends MoviesEvent {
  final String item;
  const UpdateItemEvent({required this.item});
}
class DeleteItemEvent extends MoviesEvent {
  final String item;
  const DeleteItemEvent({required this.item});
}
