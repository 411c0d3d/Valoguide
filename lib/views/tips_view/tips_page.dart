import 'dart:math';

import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/constants/data.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/models/proTipsList_model.dart';
import 'package:Valoguide/core/store/store.dart';
import 'package:Valoguide/views/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TipsPage extends StatefulWidget {
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  var sAgentIndex;
  var sMapIndex;
  final proTipsPlaceHolder = ProTipsListModel();
  var proTipsList;
  void setMapIndex(int selectedMapIndex) {
    setState(() {
      sMapIndex = selectedMapIndex;
    });
  }

  int getMapIndex() {
    return sMapIndex;
  }

  void setAgentIndex(int selectedAgentIndex) {
    setState(() {
      sAgentIndex = selectedAgentIndex;
    });
  }

  int getAgentIndex() {
    return sAgentIndex;
  }

  final WillPopCallback onWillPop = () {
    Ads?.hideBannerAd();
    return Future.value(true);
  };
  void proTipsLoader() async {
    proTipsList.setViewState(ViewState.Busy);
    await proTipsList.getProTips(
        agentNames[sAgentIndex], maps[sMapIndex]['name']);
  }

  @override
  void initState() {
    sAgentIndex = 8;
    sMapIndex = 1;
    Ads?.hideBannerAd();
    proTipsList = Provider.of<ProTipsListModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 6; i++)
      proTipsPlaceHolder?.addTip(new Tip.construct("", "", "", "", "", "", ""));
    return Consumer<ProTipsListModel>(builder: (context, __, _) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background/bg00.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: (proTipsList.listLength() > 0)
                    ? Center(
                        child: Text(
                          'Pro-Tips Section',
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
              body: Row(
                children: <Widget>[
                  AgentSideBar(
                    setAgentIndex: setAgentIndex,
                    getAgentIndex: getAgentIndex,
                    proTipsLoader: proTipsLoader,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: MapUpperBar(
                            setMapIndex: setMapIndex,
                            getMapIndex: getMapIndex,
                            proTipsLoader: proTipsLoader,
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: RefreshIndicator(
                            onRefresh: () async {
                              proTipsLoader();
                            },
                            child: (proTipsList.listLength() == 0 ||
                                    proTipsList.viewState == ViewState.Busy)
                                ? Shimmer.fromColors(
                                    baseColor: Colors.black45.withOpacity(0.8),
                                    highlightColor:
                                        Colors.blueGrey.withOpacity(0.8),
                                    child: CardsList(
                                        proTipsList: proTipsPlaceHolder),
                                  )
                                : CardsList(proTipsList: proTipsList),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
    @required this.proTipsList,
  }) : super(key: key);

  final dynamic proTipsList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.87,
      height: double.infinity,
      child: ListView.separated(
        itemCount: proTipsList?.listLength(),
        itemBuilder: (context, index) {
          return VideoCard(
            index: index,
            proTipsList: proTipsList,
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 0,
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final index;
  final proTipsList;

  const VideoCard({Key key, @required this.index, @required this.proTipsList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 4),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  final WillPopCallback onWillPopShow = () {
                    Store.navCounter++;
                    print('____________ navCount : --------- ' +
                        Store.navCounter.toString());

                    if (Store.navCounter > 5) {
                      Store.navCounter = 0;
                      Ads?.showInterstitialAd();
                    }
                    return Future.value(true);
                  };
                  final WillPopCallback onWillPopHide = () {
                    Ads?.hideInterstitialAd();
                    return Future.value(true);
                  };
                  return WillPopScope(
                    onWillPop: onWillPopHide,
                    child: WillPopScope(
                      onWillPop: onWillPopShow,
                      child: Center(
                        child: Container(
                          height: 310,
                          child: Card(
                            color: Colors.black45,
                            elevation: 15,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    proTipsList.getTipAt(index).title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: (SizeConfig.blockSizeVertical *
                                              20.0) /
                                          10,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: VideoPlayerView(
                                    clipID: proTipsList.getTipAt(index).clipId,
                                    thumbnail:
                                        proTipsList.getTipAt(index).clipThumb,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.7),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30.0),
                                          child: Text(
                                            proTipsList.getTipAt(index).dfclty,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: (SizeConfig
                                                          .blockSizeVertical *
                                                      15.0) /
                                                  6,
                                              fontFamily: "Tisa Sans",
                                              color: (proTipsList
                                                      .getTipAt(index)
                                                      .dfclty
                                                      .contains('Easy'))
                                                  ? Color(0xFF00FFA4)
                                                  : (proTipsList
                                                          .getTipAt(index)
                                                          .dfclty
                                                          .contains('Medium'))
                                                      ? Colors.orangeAccent
                                                      : (proTipsList
                                                              .getTipAt(index)
                                                              .dfclty
                                                              .contains('Pro'))
                                                          ? Colors.redAccent
                                                          : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30.0),
                                          child: Text(
                                            "Credit to : www.Blitz.gg",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Tisa Sans",
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30.0),
                                          child: Text(
                                            proTipsList
                                                    .getTipAt(index)
                                                    .map[0]
                                                    .toUpperCase() +
                                                proTipsList
                                                    .getTipAt(index)
                                                    .map
                                                    .substring(1),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Tisa Sans",
                                                color: mapColor(proTipsList
                                                    .getTipAt(index)
                                                    .map)),
                                          ),
                                        ),

                                        // Tip
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).then((value) {
              DefaultCacheManager().emptyCache();
            });
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
                    (proTipsList.getTipAt(index).clipThumb != '')
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/images/background/loading.jpg",
                            image: proTipsList.getTipAt(index).clipThumb,
                            fit: BoxFit.cover)
                        : Image.asset("assets/images/background/loading.jpg"),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          (proTipsList.getTipAt(index).title != '')
                              ? (proTipsList.getTipAt(index) != null)
                                  ? Container(
//                                          margin: EdgeInsets.only(bottom: 22),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        proTipsList.getTipAt(index).title,
                                        style: TextStyle(
//                                          color: Color(0xFF1E2241),
                                          color: Colors.white,
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
                                    )
                              : null,
                          Center(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Icon(
                                  Icons.play_circle_outline,
                                  size: 32,
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              (proTipsList.getTipAt(index) != null)
                                  ? (proTipsList.getTipAt(index).dfclty != '')
                                      ? Container(
                                          margin: EdgeInsets.only(left: 8),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 6.0),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Text(
                                            proTipsList.getTipAt(index).dfclty,
                                            style: TextStyle(
                                                fontSize: (SizeConfig
                                                            .blockSizeVertical *
                                                        15.0) /
                                                    7,
                                                fontWeight: FontWeight.bold,
                                                color: (proTipsList
                                                        .getTipAt(index)
                                                        .dfclty
                                                        .contains('Easy'))
                                                    ? Color(0xFF00FFA4)
                                                    : (proTipsList
                                                            .getTipAt(index)
                                                            .dfclty
                                                            .contains('Medium'))
                                                        ? Colors.orangeAccent
                                                        : (proTipsList
                                                                .getTipAt(index)
                                                                .dfclty
                                                                .contains(
                                                                    'Pro'))
                                                            ? Colors.redAccent
                                                            : Colors
                                                                .transparent),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 22.0, vertical: 6.0),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Text(
                                            "Difficulty : Loading",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        )
                                  : null,
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, bottom: 2),
                                  child: (proTipsList.getTipAt(index) != null)
                                      ? (proTipsList.getTipAt(index).map != '')
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
                                                proTipsList
                                                        .getTipAt(index)
                                                        .map[0]
                                                        .toUpperCase() +
                                                    proTipsList
                                                        .getTipAt(index)
                                                        .map
                                                        .substring(1),
                                                style: TextStyle(
                                                    fontFamily: "Tisa Sans",
                                                    fontSize: (SizeConfig
                                                                .blockSizeVertical *
                                                            15.0) /
                                                        7,
                                                    color: mapColor(proTipsList
                                                        .getTipAt(index)
                                                        .map)),
                                              ))
                                          : Text(
                                              "Map : Loading",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontFamily: "Tisa Sans"),
                                            )
                                      : null),
                            ],
                          ),
                        ],
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

class AgentSideBar extends StatelessWidget {
  final void Function(int) setAgentIndex;
  final int Function() getAgentIndex;
  final void Function() proTipsLoader;
  const AgentSideBar(
      {Key key,
      @required this.setAgentIndex,
      @required this.getAgentIndex,
      this.proTipsLoader})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      width: MediaQuery.of(context).size.width / 7.5,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
                reverse: true,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => SizedBox(
                      height: 2,
                    ),
                itemCount: agentNames.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 0),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 26,
                        backgroundColor: (index == getAgentIndex())
                            ? Colors.amberAccent
                            : Colors.transparent,
                        child: Image.asset(
                          "assets/images/agents/avatar/${agentNames[index].toString().toLowerCase()}.jpg",
                          width: MediaQuery.of(context).size.width / 10,
                          height: MediaQuery.of(context).size.width / 10,
                        ),
                      ),
                    ),
                    onTap: () {
                      setAgentIndex(index);
                      proTipsLoader();
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class MapUpperBar extends StatelessWidget {
  final void Function(int) setMapIndex;
  final int Function() getMapIndex;
  final void Function() proTipsLoader;
  const MapUpperBar(
      {Key key,
      @required this.setMapIndex,
      @required this.getMapIndex,
      this.proTipsLoader})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                      width: 2,
                    ),
                itemCount: maps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5, right: 0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setMapIndex(index);
                        proTipsLoader();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                width: 3,
                                color: (index == getMapIndex())
                                    ? Colors.amberAccent
                                    : Colors.black,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(3.0, 6.0),
                                    blurRadius: 10.0)
                              ]),
                          child: AspectRatio(
                            aspectRatio: (MediaQuery.of(context).size.width) /
                                (MediaQuery.of(context).size.height / 3.5),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.asset(maps[index]['cover'],
                                    fit: BoxFit.cover),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, bottom: 5.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 4.0),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Text(
                                            maps[index]['name'],
                                            //TODO : color map title by name
                                            style: TextStyle(
                                                color: mapColor(
                                                    maps[index]['name']),
                                                fontSize: (SizeConfig
                                                            .blockSizeVertical *
                                                        15.0) /
                                                    8,
                                                fontFamily: "Tisa Sans"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
