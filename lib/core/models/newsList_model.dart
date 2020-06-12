import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/services/news_service.dart';

import 'model.dart';

class NewsListModel extends Model {
  List<Post> _postList;
  ViewState viewState = ViewState.Busy;

  Future getPosts() async {
    viewState = ViewState.Busy;
    List<Post> tempPostsList = await NewsService.fetchPosts();
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
  final String title;
  final String date;
  final String content;

  Post({this.title, this.date, this.content});
  Post.construct(this.title, this.date, this.content);
}
