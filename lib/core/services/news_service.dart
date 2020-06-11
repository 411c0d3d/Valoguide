import 'dart:convert';
import 'dart:io';
import 'package:Valoguide/core/models/newsList_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static const endpoint =
      'https://jsonplaceholder.typicode.com'; // TODO : API_ENDPOINT

  var client = new http.Client();

  Future<List<Post>> fetchPosts() async {
    List<Post> _postsList = <Post>[];
    try {
      http.Response response = await client.get('$endpoint/posts');
      var parsed = json.decode(response.body) as List<dynamic>;
      await Future.delayed(Duration(seconds: 4));
      for (var post in parsed) {
        _postsList.add(Post.fromJson(post));
      }
    } on SocketException catch (e) {
      print(e);
    }
    if (_postsList.length > 0)
      return _postsList;
    else
      return null;
  }

//  @override
  dispose() {
    client.close();
    // TODO: disconnect, Stop Stream, hardware API etc
  }
}
