import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/constants/data.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/models/newsList_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
      newsPlaceHolder?.addPost(new Post.construct("", "", "", "", "", ""));
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
        return HighPostCard(
          index: index,
          eventsList: eventsList,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 0,
      ),
    );
  }
}

class HighPostCard extends StatelessWidget {
  final index;
  final eventsList;

  const HighPostCard({Key key, @required this.index, @required this.eventsList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            RoutArgument routArgument = RoutArgument();
            routArgument.postArgument =
                PostArgument(eventsList.getPostAt(index));
            Navigator.pushNamed(context, '/postDetails',
                arguments: routArgument);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(3.0, 6.0),
                    blurRadius: 10.0)
              ]),
              child: AspectRatio(
                aspectRatio: (MediaQuery.of(context).size.width) /
                    (MediaQuery.of(context).size.height / 3),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                        placeholder: "assets/images/background/loading.png",
                        image: eventsList.getPostAt(index).cover,
                        fit: BoxFit.cover),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 5, top: 20, bottom: 12),
                              child: (eventsList.getPostAt(index).title != '')
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        eventsList.getPostAt(index).title,
                                        style: TextStyle(
                                          color: Color(0xFF00FFA4),
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                      20.0) /
                                                  10,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Title",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 30),
                                    ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 12),
                                    child: (eventsList.getPostAt(index) != null)
                                        ? (eventsList.getPostAt(index).author !=
                                                '')
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 6.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: Text(
                                                  eventsList
                                                      .getPostAt(index)
                                                      .author,
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 22.0,
                                                    vertical: 6.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: Text(
                                                  "Author : Loading",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              )
                                        : null),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 12),
                                    child: (eventsList.getPostAt(index) != null)
                                        ? (eventsList.getPostAt(index).date !=
                                                '')
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 6.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: Text(
                                                  " - " +
                                                      eventsList
                                                          .getPostAt(index)
                                                          .date,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                            : Text(
                                                "Date : Loading",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                        : null),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
