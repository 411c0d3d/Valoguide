import 'dart:math';
import 'dart:ui';
import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:Valoguide/core/constants/data.dart';

import '../footer.dart';
//import 'package:flutter_config/flutter_config.dart';

class AgentDetails extends StatefulWidget {
  final AgentArguments args;
  const AgentDetails({Key key, this.args}) : super(key: key);
  @override
  _AgentDetailsState createState() => _AgentDetailsState();
}

class _AgentDetailsState extends State<AgentDetails> {
  PlayerState _playerState;
  YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  YoutubeMetaData _videoMetaData;

  @override
  initState() {
    super.initState();
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
    try {
      if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
        setState(() {
          _playerState = _controller.value.playerState;
          _videoMetaData = YoutubeMetaData();
        });
      }
    } catch (e) {
      throw Error();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    DefaultCacheManager().emptyCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(agentsImages[widget.args.agentIndex]),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1.3,
            sigmaY: 1.3,
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text(
                  'Agent ' + agentNames[widget.args.agentIndex],
                  style: TextStyle(fontFamily: "Orbitron"),
                ),
              ),
            ),
            backgroundColor: Color(0xF0B102F).withOpacity(0.75),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(flex: 4, child: _buildAgentCard(widget)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Abilities',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF00FFA4),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: ListView.separated(
                      shrinkWrap: false,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 10,
                          color: Colors.black38.withOpacity(0.5),
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 11.5,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal * 3),
                              child: ListTile(
                                title: Text(
                                  agents[widget.args.agentIndex]
                                      .abilities[index]
                                      .name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                leading: Container(
                                  width: 100,
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/agents/abilities/${agents[widget.args.agentIndex].name}_${agents[widget.args.agentIndex].abilities[index].name}.png",
                                        width: 80,
                                        color: Color(0xFF00FFA4),
                                      ),
                                      Text(
                                        agents[widget.args.agentIndex]
                                            .abilities[index]
                                            .charge,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF00FFA4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.play_circle_outline,
                                  size: 40,
                                ),
                                subtitle: Text(
                                  'cost\t:\t${agents[widget.args.agentIndex].abilities[index].cost}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        if (index == 0 || index == 3)
                                          Ads.showInterstitialAd();
                                        return Center(
                                          child: Container(
                                            height: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Color(0xF0B102F)
                                                .withOpacity(0.75),
                                            child: Column(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 7,
                                                  child: YoutubePlayer(
                                                    thumbnail: Image.asset(
                                                      "assets/images/background/loader02.gif",
                                                      width: 70,
                                                    ),
                                                    controller: _controller,
                                                    onReady: () {
                                                      _isPlayerReady = true;
                                                      _controller.addListener(
                                                          listener);
                                                      if (Ads
                                                          .interstitialIsGoingToBeShown) {
                                                        _controller.load(agents[
                                                                widget.args
                                                                    .agentIndex]
                                                            .abilities[index]
                                                            .clipId);
                                                        _controller.pause();
                                                      } else {
                                                        if (index ==
                                                                new Random()
                                                                    .nextInt(
                                                                        4) ||
                                                            index ==
                                                                new Random()
                                                                    .nextInt(4))
                                                          Ads.showInterstitialAd();
                                                        _controller.load(agents[
                                                                widget.args
                                                                    .agentIndex]
                                                            .abilities[index]
                                                            .clipId);
                                                        _controller.pause();
                                                      }
                                                    },
                                                    showVideoProgressIndicator:
                                                        true,
                                                    progressColors:
                                                        ProgressBarColors(
                                                      playedColor:
                                                          Colors.redAccent,
                                                      handleColor:
                                                          Colors.redAccent,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Card(
                                                    elevation: 15,
                                                    color: Colors.black45,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        agents[widget.args
                                                                .agentIndex]
                                                            .abilities[index]
                                                            .description,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              "Tisa Sans",
                                                          color:
                                                              Color(0xFF00FFA4),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }).then(
                                    (value) {
                                      _controller.reset();
                                      Ads?.hideInterstitialAd();
                                    },
                                  ).catchError((context) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              content:
                                                  Text('Check your network'));
                                        });
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 0,
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

//"assets/images/agents/avatar/${agents[args.agentIndex].name}.jpg",
//FlutterConfig.get('FABRIC_ID')

Widget _buildAgentCard(widget) {
  return LayoutBuilder(
    builder: (context, constraints) {
      dynamic height = constraints.maxHeight * 0.75;
      return Card(
        color: Colors.black45.withOpacity(0.5),
        elevation: 16,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background/texture01.png',
                ),
                fit: BoxFit.cover),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.10, left: 10),
                        child: Text(
                          '${agents[widget.args.agentIndex].name}',
                          style: TextStyle(
                              fontSize:
                                  agents[widget.args.agentIndex].name.length > 5
                                      ? 14
                                      : 18,
                              fontFamily: "Valorant"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: height * 0.25),
                        child: Image.asset(
                          "assets/images/agents/avatar/${agents[widget.args.agentIndex].name.toString().toLowerCase()}.jpg",
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 2.0,
                height: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: (height * 0.23).toDouble(),
                      bottom: 10,
                      right: 5,
                      left: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Class\t\t\t\t\t\t:\t'),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Rank\t\t\t\t\t\t\t:'),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Origins\t\t\t:'),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Text('${agents[widget.args.agentIndex].type}'),
                            SizedBox(
                              height: 20,
                            ),
                            Text('${agents[widget.args.agentIndex].rank}'),
                            SizedBox(
                              height: 20,
                            ),
                            Text('${agents[widget.args.agentIndex].origin}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 2.0,
                height: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.08),
                        child: Text(
                          'Bio',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: FloatingActionButton(
                          backgroundColor: Color(0xFF00FFA4),
                          child: Icon(
                            Icons.import_contacts,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Colors.black45.withOpacity(0.8),
                                    content: Text(
                                      agents[widget.args.agentIndex]
                                          .description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Tisa Sans",
                                        color: Color(0xFF00FFA4),
                                      ),
                                    ),
                                  );
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
