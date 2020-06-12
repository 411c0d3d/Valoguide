import 'package:Valoguide/core/models/newsList_model.dart';
import 'package:http/http.dart'
    as http; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';

class NewsService {
  static Future fetchPosts() async {
    var client = http.Client();
    http.Response response =
        await client.get('https://www.techspot.com/tag/valorant/');

    if (response.statusCode != 200) return response.body;

    var document = parse(response.body);
    List<Post> posts = [];

    Element newsSections = document.querySelector('.post-list');
    List<Element> newsRows = newsSections.querySelectorAll('article');
    Element eventsItem;
    print(newsRows.length);
    var title = '';
    List<Element> paragraphs = [];
    var date = '';
    var content = '';
    var link = '';

    for (var eventsRow in newsRows) {
      eventsItem = eventsRow.querySelector('.article-content');
      title = eventsItem.querySelector('h2').text.trim();
      date = eventsItem.querySelector('time').querySelector('span').text;

      link =
          eventsItem.querySelector('h2').querySelector('a').attributes['href'];
      http.Response postResponse = await client.get(link);
      if (postResponse.statusCode != 200) return postResponse.body;

      var postDocument = parse(postResponse.body);

      Element postBody = postDocument.querySelector('.articleBody');

      paragraphs = postBody.querySelectorAll('p');
      for (var p in paragraphs) {
        content += "\n\n\t\t\t\t ${p.text}";
      }
      posts.add(Post.construct(title, date, content));
    }

    return posts;
  }
}
