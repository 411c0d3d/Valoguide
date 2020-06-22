import 'package:Valoguide/core/models/newsList_model.dart';
import 'package:http/http.dart'
    as http; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';

class NewsService {
  static Future fetchPosts() async {
    var client = http.Client();

    http.Response response =
        await client.get('https://dotesports.com/valorant');

    if (response.statusCode != 200) return response.body;

    var document = parse(response.body);
    List<Post> posts = [];

    Element newsSections = document.querySelector('main');
    List<Element> heroPosts = document.getElementsByClassName('hero-post-item');
    List<Element> newsRows = newsSections.querySelectorAll('article');
    Element eventsItem;
    print(newsRows.length);
    var title = '';
    List<Element> paragraphes = [];
    var date = '';
    var figure = '';
    var content = '';
    var link = '';
    var author = '';
    var cover = '';

    for (var heroPost in heroPosts) {
      cover = heroPost.getElementsByTagName('img')[0].attributes['src'];
      title = heroPost
          .querySelector('.info')
          .querySelector('.entry-title')
          .querySelector('a')
          .text
          .trim();
      date =
          heroPost.querySelector('.posted-on').querySelector('.published').text;
      author = heroPost
          .querySelector('.byline')
          .querySelector('span')
          .querySelector('a')
          .text;
      link = heroPost
          .querySelector('.entry-title')
          .querySelector('a')
          .attributes['href'];

      http.Response postResponse = await client.get(link);
      if (postResponse.statusCode != 200) return postResponse.body;

      var postDocument = parse(postResponse.body);

      Element postBody = postDocument.querySelector('.entry-content');
      if (postBody.querySelectorAll('figure').length != 0) if (postBody
              .querySelectorAll('figure')[0]
              .querySelectorAll("img")
              .length !=
          0)
        figure = postBody
            .querySelectorAll('figure')[0]
            .querySelectorAll("img")[0]
            .attributes['src'];
      paragraphes = postBody.querySelectorAll('p');
      for (var p in paragraphes) {
        content += "\n\t\t\t\t ${p.text}";
      }
      posts.add(Post.construct(title, date, content, author, figure, cover));
      content = '';
    }

    for (var eventsRow in newsRows) {
      eventsItem = eventsRow.querySelector('.right');
      title = eventsRow
          .querySelector('.entry-title')
          .querySelector('a')
          .text
          .trim();
      date = eventsItem
          .querySelector('.posted-on')
          .querySelector('.published')
          .text;
      author = eventsItem
          .querySelector('.byline')
          .querySelector('span')
          .querySelector('a')
          .text;
      link = eventsRow
          .querySelector('.entry-title')
          .querySelector('a')
          .attributes['href'];

      cover = eventsRow
          .querySelector('.attachment-post-thumbnail')
          .attributes['src'];

      http.Response postResponse = await client.get(link);
      if (postResponse.statusCode != 200) return postResponse.body;

      var postDocument = parse(postResponse.body);

      Element postBody = postDocument.querySelector('.entry-content');

      paragraphes = postBody.querySelectorAll('p');
      for (var p in paragraphes) {
        content += "\n\t\t\t\t ${p.text}";
        if (postBody.querySelectorAll('figure').length != 0) if (postBody
                .querySelectorAll('figure')[0]
                .querySelectorAll("img")
                .length !=
            0)
          figure = postBody
              .querySelectorAll('figure')[0]
              .querySelectorAll("img")[0]
              .attributes['src'];
      }
      posts.add(Post.construct(title, date, content, author, figure, cover));
      content = '';
    }
//    posts.forEach((post) {
//      print(
//          "TITLE : ${post.title},\n DATE : ${post.date}, \n CONTENT : ${post.content} \n AUTHOR : ${post.author},\n  FIGURE : ${post.figure} , Cover : ${post.cover}");
//    });
    return posts;
  }
}
