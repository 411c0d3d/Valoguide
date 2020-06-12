import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/constants/data.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/models/newsList_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../coming_soon.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    Ads?.showBannerAd();
    super.initState();
  }

  final WillPopCallback onWillPop = () {
    Ads?.hideBannerAd();
    return Future.value(true);
  };

  @override
  Widget build(BuildContext context) {
    final newsList = Provider.of<NewsListModel>(context, listen: false);
    final newsPlaceHolder = NewsListModel();
    for (var i = 0; i < 6; i++)
      newsPlaceHolder?.addPost(new Post.construct("", "", ""));
    return Consumer<NewsListModel>(builder: (context, __, _) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background/bg00.png"),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: (newsList.listLength() > 0)
                    ? Center(
                        child: Text(
                          'News Section',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Orbitron"),
                        ),
                      )
                    : Text(
                        'Check your network connection  ...  pull to refresh ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, fontFamily: "Tisa Sans"),
                      ),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  newsList.setViewState(ViewState.Busy);
                  await newsList.getPosts();
                },
                child: (newsList.listLength() == 0 ||
                        newsList.viewState == ViewState.Busy)
                    ? Shimmer.fromColors(
//                        baseColor: Color(0xFF080618).withOpacity(0.8),
//                        highlightColor: Color(0xFF120840).withOpacity(0.7),
                        baseColor: Colors.black45.withOpacity(0.8),
                        highlightColor: Colors.blueGrey.withOpacity(0.8),
                        child: CardsList(eventsList: newsPlaceHolder),
                      )
                    : CardsList(eventsList: newsList),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CardsList extends StatelessWidget {
  const CardsList({
    Key key,
    @required this.eventsList,
  }) : super(key: key);

  final dynamic eventsList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: eventsList?.listLength(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 6,
            color: Colors.black45.withOpacity(0.4),
            child: InkWell(
              onTap: () {
                RoutArgument routArgument = RoutArgument();
                routArgument.postArgument = PostArgument(
                    eventsList.getPostAt(index).title,
                    eventsList.getPostAt(index).content);
                Navigator.pushNamed(context, '/postDetails',
                    arguments: routArgument);
              },
              child: Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 20, bottom: 12),
                      child: Row(
                        children: <Widget>[
                          (eventsList.getPostAt(index).title != '')
                              ? Expanded(
                                  child: Text(
                                    eventsList.getPostAt(index)?.title,
                                    style: TextStyle(
                                        color: Color(0xFF00FFA4),
                                        fontSize: (eventsList
                                                    .getPostAt(index)
                                                    .title
                                                    .length <
                                                30)
                                            ? 22
                                            : 15),
                                  ),
                                )
                              : Text(
                                  "Title",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 30),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 12),
                        child: (eventsList.getPostAt(index) != null)
                            ? (eventsList.getPostAt(index).date != '')
                                ? Text(
                                    "Date : " +
                                        eventsList.getPostAt(index).date,
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    "Date : Loading",
                                    style: TextStyle(color: Colors.white),
                                  )
                            : null),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 0,
      ),
    );
  }
}
