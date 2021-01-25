import 'package:bloc_pattern_flutter_app/models/albums_list.dart';

abstract class AlbumsRepo {
  Future<List<Album>> getAlbumList();
}