import 'dart:math';
import 'dart:ui';
import 'package:Valoguide/core/constants/adMob.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:Valoguide/core/constants/data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../footer.dart';

class WeaponDetails extends StatefulWidget {
  final WeaponArguments args;

  const WeaponDetails({Key key, this.args}) : super(key: key);

  @override
  _WeaponDetailsState createState() => _WeaponDetailsState();
}

class _WeaponDetailsState extends State<WeaponDetails> {
  PlayerState _playerState;
  YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  YoutubeMetaData _videoMetaData;
  bool isExpanded;

  final GlobalKey<ConfigurableExpansionTileState> expansionTileGlobalKey =
      new GlobalKey();
  _onExpansionChanged(bool isExpanded) {
    _controller.reset();
    DefaultCacheManager().emptyCache();
    if (new Random().nextInt(2) == new Random().nextInt(2))
      Ads?.showInterstitialAd();
  }

  @override
  initState() {
    super.initState();
    Ads.hideInterstitialAd();
    isExpanded = true;
    _controller = YoutubePlayerController(
      initialVideoId: '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: false,
      ),
    )..addListener(listener);
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = YoutubeMetaData();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WillPopCallback onWillPop = () {
      if (new Random().nextInt(2) == new Random().nextInt(2))
        Ads?.showInterstitialAd();
      return Future.value(true);
    };
    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
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
              weaponNames[widget.args.weaponType][widget.args.weaponIndex]
                  ['name'],
              style: TextStyle(fontFamily: "Orbitron"),
            )),
          ),
          backgroundColor: Color(0xF0B102F).withOpacity(0.5),
          body: Container(
            child: Column(
              children: <Widget>[
                Center(
                    child: Container(
                  child: ConfigurableExpansionTile(
                      onExpansionChanged: _onExpansionChanged,
                      key: expansionTileGlobalKey,
                      initiallyExpanded: true,
                      headerBackgroundColorStart:
                          Colors.black45.withOpacity(0.4),
                      borderColorEnd: Color(0xFFBF2041),
                      animatedWidgetFollowingHeader: Icon(
                        Icons.play_circle_outline,
                      ),
                      headerExpanded: Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(" -- Hide Clip  ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontFamily: "Valorant")),
                      ),
                      header: Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(" -- Play Clip  ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontFamily: "Valorant")),
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black45.withOpacity(0.8),
                          child: YoutubePlayer(
                            thumbnail: Image.network(
                                "https://i.redd.it/qg4enmbd90t41.png"),
                            controller: _controller,
                            onReady: () {
                              _isPlayerReady = true;
                              _controller.addListener(listener);
                              _controller.load(
                                  weaponNames[widget.args.weaponType]
                                      [widget.args.weaponIndex]['clip']);
                            },
                            onEnded: (data) {
                              _controller.reset();
                              DefaultCacheManager().emptyCache();
                              expansionTileGlobalKey.currentState.toggle();
                            },
                            showVideoProgressIndicator: false,
                          ),
                        ),
                      ]),
                )),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Image.asset(
                            "assets/images/weapons/weaponsCard/${weaponNames[widget.args.weaponType][widget.args.weaponIndex]['name'].toString().toLowerCase()}.png"),
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
    );
  }
}
