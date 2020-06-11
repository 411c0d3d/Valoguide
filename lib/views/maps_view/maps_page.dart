import 'package:Valoguide/core/constants/adMob.dart';
import 'package:flutter/material.dart';
import 'package:Valoguide/core/constants/data.dart';

import '../footer.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  void initState() {
    // TODO: implement initState
    Ads?.showBannerAd();
    super.initState();
  }

  final WillPopCallback onWillPop = () {
    Ads?.hideBannerAd();
    return Future.value(true);
  };

  @override
  Widget build(BuildContext context) {
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
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Center(
                  child: Text(
                    'Maps Section',
                    style: TextStyle(fontFamily: "Orbitron"),
                  ),
                )),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        RoutArgument routArgument = RoutArgument();
                        routArgument.mapArguments =
                            MapArguments(0, Colors.pink, '');
                        Navigator.pushNamed(context, '/mapDetails',
                            arguments: routArgument);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
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
                                Image.asset(maps[0]['cover'],
                                    fit: BoxFit.cover),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SingleChildScrollView(
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
                                              left: 12.0, bottom: 12.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22.0,
                                                vertical: 6.0),
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Text(
                                              maps[0]['name'],
                                              style: TextStyle(
                                                color: Colors.pink,
                                                fontSize: 15,
                                                fontFamily: "Orbitron",
                                              ),
                                            ),
                                          ),
                                        )
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        RoutArgument routArgument = RoutArgument();
                        routArgument.mapArguments =
                            MapArguments(1, Colors.green, '');
                        Navigator.pushNamed(context, '/mapDetails',
                            arguments: routArgument);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
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
                                Image.asset(maps[1]['cover'],
                                    fit: BoxFit.cover),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SingleChildScrollView(
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
                                              left: 12.0, bottom: 12.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22.0,
                                                vertical: 6.0),
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Text(
                                              maps[1]['name'],
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                  fontFamily: "Orbitron"),
                                            ),
                                          ),
                                        )
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        RoutArgument routArgument = RoutArgument();
                        routArgument.mapArguments =
                            MapArguments(2, Colors.amber, '');
                        Navigator.pushNamed(context, '/mapDetails',
                            arguments: routArgument);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
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
                                Image.asset(maps[2]['cover'],
                                    fit: BoxFit.cover),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SingleChildScrollView(
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
                                              left: 12.0, bottom: 12.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22.0,
                                                vertical: 6.0),
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Text(
                                              maps[2]['name'],
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 15,
                                                  fontFamily: "Orbitron"),
                                            ),
                                          ),
                                        )
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        RoutArgument routArgument = RoutArgument();
                        routArgument.mapArguments =
                            MapArguments(3, Colors.cyan, '');
                        Navigator.pushNamed(context, '/mapDetails',
                            arguments: routArgument);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
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
                                Image.asset(maps[3]['cover'],
                                    fit: BoxFit.cover),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SingleChildScrollView(
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
                                              left: 12.0, bottom: 12.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22.0,
                                                vertical: 6.0),
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Text(
                                              maps[3]['name'],
                                              style: TextStyle(
                                                  color: Colors.cyan,
                                                  fontSize: 15,
                                                  fontFamily: "Orbitron"),
                                            ),
                                          ),
                                        )
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
                ],
              ),
            ),
            bottomNavigationBar: Footer(),
          ),
        ),
      ),
    );
  }
}
