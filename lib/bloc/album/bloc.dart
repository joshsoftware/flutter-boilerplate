// event, state => new state => update UI.

import 'dart:io';

import 'package:bloc_pattern_flutter_app/api/album/album_repository.dart';
import 'package:bloc_pattern_flutter_app/api/exceptions.dart';
import 'package:bloc_pattern_flutter_app/bloc/album/events.dart';
import 'package:bloc_pattern_flutter_app/bloc/album/states.dart';
import 'package:bloc_pattern_flutter_app/models/albums_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsBloc extends Bloc<AlbumEvents, AlbumsState> {
  //
  final AlbumsRepo albumsRepo;
  List<Album> albums;

  AlbumsBloc({this.albumsRepo}) : super(AlbumsInitState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumEvents event) async* {
    switch (event) {
      case AlbumEvents.fetchAlbums:
        yield AlbumsLoading();
        try {
          albums = await albumsRepo.getAlbumList();
          yield AlbumsLoaded(albums: albums);
        } on SocketException {
          yield AlbumsListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield AlbumsListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield AlbumsListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield AlbumsListError(
            error: UnknownException('Unknown Error'),
          );
        }

        break;
    }
  }
}
final albumBloc = AlbumsBloc();
