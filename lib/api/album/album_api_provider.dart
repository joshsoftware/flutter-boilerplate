import 'package:bloc_pattern_flutter_app/api/album/album_repository.dart';
import 'package:bloc_pattern_flutter_app/models/albums_list.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class AlbumServices implements AlbumsRepo {
  //
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _GET_ALBUMS = '/albums';

  @override
  Future<List<Album>> getAlbumList() async {
    Uri uri = Uri.https(_baseUrl, _GET_ALBUMS);
    Response response = await http.get(uri);
    List<Album> albums = albumFromJson(response.body);
    return albums;
  }
}