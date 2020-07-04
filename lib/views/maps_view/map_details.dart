import 'dart:ui';
import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/store/store.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:Valoguide/core/constants/data.dart';

import '../footer.dart';

class MapDetails extends StatefulWidget {
  final args;

  const MapDetails({Key key, this.args}) : super(key: key);

  @override
  _MapDetailsState createState() => _MapDetailsState();
}

class _MapDetailsState extends State<MapDetails> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WillPopCallback onWillPop = () {
      Store.navCounter++;
      print('____________ navCount : --------- ' + Store.navCounter.toString());

      if (Store.navCounter > 5) {
        Store.navCounter = 0;
        Ads?.showInterstitialAd();
      }
      return Future.value(true);
    };
    return WillPopScope(
      onWillPop: onWillPop,
      child: LayoutBuilder(builder: (context, constraints) {
        dynamic height = constraints.maxHeight * 0.75;
        return Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(maps[widget.args.mapIndex]['cover']),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Center(
                  child: Text(
                    maps[widget.args.mapIndex]['name'],
                    style: TextStyle(fontFamily: "Orbitron"),
                  ),
                ),
              ),
              backgroundColor: Color(0xF0B102F).withOpacity(0.75),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            maps[widget.args.mapIndex]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: widget.args.mapColor,
                                fontSize: 20,
                                fontFamily: "valorant"),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.info_outline,
                                size: 15,
                              ),
                              Text(
                                "  Zoom-in",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Card(
                        elevation: 20,
                        color: Colors.black.withOpacity(0.4),
                        child: Container(
                          color: Colors.transparent,
                          child: PhotoView(
                            maxScale: PhotoViewComputedScale.covered * 1,
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
                            imageProvider:
                                AssetImage(maps[widget.args.mapIndex]['plan']),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: InkWell(
                                radius: 50,
                                child: Card(
                                  elevation: 20,
                                  color: Colors.black.withOpacity(0.4),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: height / 17),
                                          child: Text(
                                            'Defenders',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFFE53645),
                                                fontFamily: "valorant"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Image.asset(
                                            "assets/icons/defend.png",
                                            color: Color(0xFFE53645),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  RoutArgument routArgument = RoutArgument();
                                  routArgument.mapArguments = MapArguments(
                                      widget.args.mapIndex,
                                      Color(0xFFff6e6e),
                                      'defenders');
                                  Navigator.pushNamed(context, '/mapGuide',
                                      arguments: routArgument);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: InkWell(
                                radius: 50,
                                child: Card(
                                  elevation: 20,
                                  color: Colors.black.withOpacity(0.4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: height / 17),
                                          child: Text(
                                            'Attackers',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF00FFA4),
                                                fontFamily: "valorant"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Image.asset(
                                            "assets/icons/attack.png",
                                            color: Color(0xFF00FFA4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  RoutArgument routArgument = RoutArgument();
                                  routArgument.mapArguments = MapArguments(
                                      widget.args.mapIndex,
                                      Color(0xFF00FFA4),
                                      'attackers');
                                  Navigator.pushNamed(context, '/mapGuide',
                                      arguments: routArgument);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Footer(),
            ),
          ),
        );
      }),
    );
  }
}
