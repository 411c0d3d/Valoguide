import 'package:Valoguide/core/constants/adMob.dart';
import 'package:flutter/material.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/constants/data.dart';
import 'dart:math';

import '../footer.dart';

class AgentsPage extends StatefulWidget {
  @override
  _AgentsPageState createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  var currentPage = agentsImages.length - 1.0;
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
    PageController controller =
        PageController(initialPage: agentsImages.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text(
                  'Agents Section',
                  style: TextStyle(fontFamily: "Orbitron"),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.98,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF00FFA4),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        (SizeConfig.blockSizeHorizontal * 3),
                                    vertical: 6.0),
                                child: Text("Inspect Agent Profile",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Stack(
                        children: <Widget>[
                          CardScrollWidget(currentPage),
                          Positioned.fill(
                            child: PageView.builder(
                              itemCount: agentsImages.length,
                              controller: controller,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      RoutArgument routArgument =
                                          RoutArgument();
                                      routArgument.agentArguments =
                                          AgentArguments(index);
                                      Navigator.pushNamed(
                                          context, '/agentDetails',
                                          arguments: routArgument);
                                    },
                                    child: Container());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              child: Image.asset(
                                  'assets/images/legends/agentsLegend.jpg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Footer(),
          ),
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  final currentPage;
  final padding = 20.0;
  final verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < agentsImages.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(agentsImages[i], fit: BoxFit.contain),
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
                                    left: 12.0, bottom: 12.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    agentNames[i],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            (SizeConfig.blockSizeVertical *
                                                    30.0) /
                                                10,
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
          );
          cardList.add(
            cardItem,
          );
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
