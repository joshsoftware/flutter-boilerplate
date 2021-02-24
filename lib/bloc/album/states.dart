import 'package:bloc_pattern_flutter_app/models/albums_list.dart';
import 'package:equatable/equatable.dart';

abstract class AlbumsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumsInitState extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;

  AlbumsLoaded({this.albums});
}

class AlbumsListError extends AlbumsState {
  final error;

  AlbumsListError({this.error});
}
