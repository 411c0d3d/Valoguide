import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'dart:ui';

import 'package:Valoguide/core/constants/data.dart';
import 'package:rate_my_app/rate_my_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double aspectRatio;
  final RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    // TODO : change to 5 days 11 launches
    minDays: 1,
    minLaunches: 2,
    remindDays: 2,
    remindLaunches: 2,
    googlePlayIdentifier: 'com.Valoguide',
  );
  @override
  void initState() {
    // TODO: implement initState
    Ads.hideBannerAd();

    super.initState();
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showStarRateDialog(
          context,
          title: 'Hi Agent!', // The dialog title.
          message:
              " 🙏🏼 Let's borrow a moment for a quick rating.", // The dialog message.
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          actionsBuilder: (context, stars) {
            // Triggered when the user updates the star rating.
            return [
              // Return a list of actions (that will be shown at the bottom of the dialog).
              FlatButton(
                child: Text('Submit'),
                onPressed: () {
                  print('Thanks for the ' +
                      (stars == null ? '0' : stars.round().toString()) +
                      ' star(s) !');
                  if (stars >= 3) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content: Container(
                              color: Colors.black45.withOpacity(0.7),
                              child: Text(
                                'Leaving a review would be appreciated ...',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Tisa Sans"),
                              ),
                            ),
                          );
                        }).then((value) {
                      rateMyApp.launchStore();
                    });
                    rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                    Navigator.pop<RateMyAppDialogButton>(
                        context, RateMyAppDialogButton.rate);
                  }
                },
              ),
            ];
          },
          ignoreIOS:
              true, // Set to false if you want to show the native Apple app rating dialog on iOS.
          dialogStyle: DialogStyle(
            // Custom dialog styles.
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20),
          ),
          starRatingOptions:
              StarRatingOptions(), // Custom star bar rating options.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    aspectRatio = 0.5;
    Ads.hideBannerAd();
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background/bg01.png"),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Center(
              child: Text(
                'Valorant Master Guide',
                style: TextStyle(fontFamily: "Orbitron"),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Main Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            DashButton(
                              dashTitle: 'Agents',
                              route: routes['agents'],
                              dashColor: dashColors['agents'],
                              iconPath: dashIcons['agents'],
                            ),
                            SizedBox(
                              width: 2.0,
                              height: 100,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.4),
                                ),
                              ),
                            ),
                            DashButton(
                              dashTitle: 'Maps',
                              route: routes['maps'],
                              dashColor: dashColors['maps'],
                              iconPath: dashIcons['maps'],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 2.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            DashButton(
                              dashTitle: 'Weapons',
                              route: routes['weapons'],
                              dashColor: dashColors['weapons'],
                              iconPath: dashIcons['weapons'],
                            ),
                            SizedBox(
                              width: 2.0,
                              height: 100,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.4),
                                ),
                              ),
                            ),
                            DashButton(
                              dashTitle: 'Events',
                              route: routes['events'],
                              dashColor: dashColors['events'],
                              iconPath: dashIcons['events'],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 2.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            DashButton(
                              dashTitle: 'News',
                              route: routes['news'],
                              dashColor: dashColors['news'],
                              iconPath: dashIcons['news'],
                            ),
                            SizedBox(
                              width: 2.0,
                              height: 100,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.4),
                                ),
                              ),
                            ),
                            DashButton(
                              dashTitle: ''
                                  'pro-tips',
                              route: routes['tips'],
                              dashColor: dashColors['tips'],
                              iconPath: dashIcons['tips'],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DashButton extends StatelessWidget {
  final route;
  final dashColor;
  final iconPath;
  final dashTitle;
  const DashButton(
      {Key key, this.route, this.dashColor, this.iconPath, this.dashTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
            top: (SizeConfig.blockSizeVertical * 2),
            bottom: (SizeConfig.blockSizeVertical * 2),
            left: (SizeConfig.blockSizeHorizontal * 3),
            right: (SizeConfig.blockSizeHorizontal * 3)),
        // padding: EdgeInsets.all(0),
        child: Card(
          elevation: 20,
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Center(
                child: InkWell(
                  splashColor: Colors.white,
                  radius: 55,
                  onTap: () {
                    Navigator.pushNamed(context, route);
                  },
                  child: Container(
                    decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(30.0),
                        color: Colors.black12.withOpacity(0.4)),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(child: _buildCircleAvatar(iconPath)),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8.0,
                              bottom: SizeConfig.blockSizeVertical * 2),
                          child: Text(
                            dashTitle,
                            style: TextStyle(
                              color: Color(dashColor),
                              fontSize:
                                  (SizeConfig.blockSizeVertical * 14.0) / 6,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Color(0xFF140D22)
// Color(0xF1E2241).withOpacity(0.6)

Widget _buildCircleAvatar(iconPath) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final radius =
          min(constraints.maxHeight / 2.5, constraints.maxWidth / 2.5);
      return Center(
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.transparent,
          child: Image.asset(iconPath),
        ),
      );
    },
  );
}
