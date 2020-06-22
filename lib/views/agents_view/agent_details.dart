import 'dart:math';
import 'dart:ui';
import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Valoguide/core/constants/data.dart';

import '../footer.dart';
import '../video_player.dart';

class AgentDetails extends StatefulWidget {
  final AgentArguments args;
  const AgentDetails({Key key, this.args}) : super(key: key);
  @override
  _AgentDetailsState createState() => _AgentDetailsState();
}

class _AgentDetailsState extends State<AgentDetails> {
  @override
  initState() {
    super.initState();
    Ads.hideInterstitialAd();
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
                          height: SizeConfig.blockSizeVertical * 10,
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                agents[widget.args.agentIndex]
                                    .abilities[index]
                                    .name,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            leading: Container(
                              width: SizeConfig.blockSizeVertical * 11.5,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      "assets/images/agents/abilities/${agents[widget.args.agentIndex].name}_${agents[widget.args.agentIndex].abilities[index].name}.png",
                                      height:
                                          SizeConfig.blockSizeVertical * 9.5,
                                      color: Color(0xFF00FFA4),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            agents[widget.args.agentIndex]
                                                .abilities[index]
                                                .chargeIcon,
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    9.5,
                                            color: Color(0xFF00FFA4),
                                          ),
                                          Text(
                                            '\t${agents[widget.args.agentIndex].abilities[index].key}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF00FFA4),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Icon(
                              Icons.play_circle_outline,
                              size: 40,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'cost\t:\t${agents[widget.args.agentIndex].abilities[index].cost}',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    final WillPopCallback onWillPopShow = () {
                                      if (new Random().nextInt(2) ==
                                          new Random().nextInt(2))
                                        Ads?.showInterstitialAd();
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
                                                  VideoPlayer(
                                                    clipID: agents[widget
                                                            .args.agentIndex]
                                                        .abilities[index]
                                                        .clipId,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      agents[widget
                                                              .args.agentIndex]
                                                          .abilities[index]
                                                          .description,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Tisa Sans",
                                                        color:
                                                            Color(0xFF00FFA4),
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
                                  });
                            },
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
    );
  }
}

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
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 2.0,
                  height: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: (height * 0.40).toDouble(),
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
                          Text('Tier\t\t\t\t\t\t\t:'),
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Text(
                                        '${agents[widget.args.agentIndex].type}'),
                                  ),
                                  Image.asset(
                                      'assets/images/agents/classes/${agents[widget.args.agentIndex].type}.webp'),
                                ],
                              ),
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
