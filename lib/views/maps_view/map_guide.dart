import 'dart:math';

import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/store/store.dart';
import 'package:Valoguide/views/footer.dart';
import 'package:flutter/material.dart';
import 'package:Valoguide/core/constants/data.dart';

class MapGuide extends StatefulWidget {
  final args;

  const MapGuide({Key key, this.args}) : super(key: key);

  @override
  _MapGuideState createState() => _MapGuideState();
}

class _MapGuideState extends State<MapGuide> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WillPopCallback onWillPopFirst = () {
      Store.navCounter++;
      print('____________ navCount : --------- ' + Store.navCounter.toString());

      if (Store.navCounter > 5) {
        Store.navCounter = 0;
        Ads?.showInterstitialAd();
      }
      return Future.value(true);
    };

    List<Widget> guideList =
        maps[widget.args.mapIndex][widget.args.mapSide].map<Widget>((guide) {
      int index =
          maps[widget.args.mapIndex][widget.args.mapSide].indexOf(guide);
      print('Index ::: ----- ' + index.toString());
      List<String> coverPaths;
      coverPaths = maps[widget.args.mapIndex]['mapCovers'];
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Center(
              child: Text(
                (index == 0)
                    ? "-x-  A-Site  -x-"
                    : (index == 1)
                        ? "-x-  B-Site  -x-"
                        : (index == 2 &&
                                maps[widget.args.mapIndex]['name'] == 'Split')
                            ? "-x-  Mid  -x-"
                            : "-x-  C-Site  -x-",
                style: TextStyle(
                    fontSize: 24,
                    color: ((widget.args.mapSide != 'attackers')
                        ? Color(0xFFff6e6e)
                        : Color(0xFF00FFA4))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: (MediaQuery.of(context).size.height / 3.5),
              width: (MediaQuery.of(context).size.width * 0.95),
              child: Image.asset(
                coverPaths[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Card(
              color: Colors.black54.withOpacity(0.3),
              elevation: 10,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    guide,
                    style: TextStyle(fontSize: 18, fontFamily: "Tisa Sans"),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
    //
    return WillPopScope(
      onWillPop: onWillPopFirst,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background/bg00.jpg"),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Center(
                child: Text(
              widget.args.mapSide + " / " + maps[widget.args.mapIndex]['name'],
              style: TextStyle(fontFamily: "Orbitron"),
            )),
          ),
          backgroundColor: Color(0xF0B102F).withOpacity(0.5),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: guideList),
            ),
          ),
          bottomNavigationBar: Footer(),
        ),
      ),
    );
  }
}
