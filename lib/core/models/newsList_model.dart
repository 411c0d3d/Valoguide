import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/services/news_service.dart';

import 'model.dart';

class NewsListModel extends Model {
  List<Post> _postList;
  ViewState viewState = ViewState.Busy;

  Future getPosts() async {
    viewState = ViewState.Busy;
    NewsService postService = NewsService();
    List<Post> tempPostsList = await postService.fetchPosts();
    _postList = (tempPostsList != null) ? tempPostsList : _postList;
    viewState = ViewState.Idle;
    notifyListeners();
  }

  getPostAt(int index) {
    if (_postList != null) {
      return _postList[index];
    } else {
      return 0;
    }
  }

  addPost(Post post) {
    if (_postList != null) {
      _postList.add(post);
    } else {
      this._postList = <Post>[];
      _postList.add(post);
    }
    notifyListeners();
  }

  listLength() {
    if (_postList != null) {
      return _postList.length;
    } else {
      return 0;
    }
  }

  removePostAt(int index) {
    if (_postList.length > index) {
      _postList.removeAt(index);
      notifyListeners();
    } else {
      return;
    }
  }
}

class Post {
  int postId;
  int userId;
  String title;
  String body;

  Post({this.postId, this.title, this.body, this.userId});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    postId = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.postId;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }

//  @override
  dispose() {
    // TODO: disconnect, Stop Stream, hardware API etc
  }
}
