import 'package:Valoguide/core/constants/adMob.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Valoguide/core/constants/data.dart';

import '../footer.dart';

class WeaponsPage extends StatefulWidget {
  @override
  _WeaponsPageState createState() => _WeaponsPageState();
}

class _WeaponsPageState extends State<WeaponsPage> {
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
                    'Weapons Section',
                    style: TextStyle(fontFamily: "Orbitron"),
                  )),
                ),
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ConfigurableExpansionTile(
                          headerBackgroundColorStart:
                              Colors.black45.withOpacity(0.4),
                          borderColorEnd: Color(0xFFBF2041),
                          animatedWidgetFollowingHeader: Icon(
                            Icons.expand_more,
                          ),
                          headerExpanded: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Sidearm',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          header: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Sidearm',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          children: <Widget>[
                            CardsList(
                                weaponNamesByType: weaponNames['sidearm'],
                                type: 'sidearm'),
                          ]),
                      ConfigurableExpansionTile(
                          headerBackgroundColorStart:
                              Colors.black45.withOpacity(0.4),
                          borderColorEnd: Color(0xFFBF2041),
                          animatedWidgetFollowingHeader: Icon(
                            Icons.expand_more,
                          ),
                          headerExpanded: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('SMG',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          header: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('SMG',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          children: <Widget>[
                            CardsList(
                                weaponNamesByType: weaponNames['smg'],
                                type: 'smg'),
                          ]),
                      ConfigurableExpansionTile(
                          headerBackgroundColorStart:
                              Colors.black45.withOpacity(0.4),
                          borderColorEnd: Color(0xFFBF2041),
                          animatedWidgetFollowingHeader: Icon(
                            Icons.expand_more,
                          ),
                          headerExpanded: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Shotgun',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          header: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Shotgun',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          children: <Widget>[
                            CardsList(
                                weaponNamesByType: weaponNames['shotgun'],
                                type: 'shotgun'),
                          ]),
                      ConfigurableExpansionTile(
                          initiallyExpanded: true,
                          headerBackgroundColorStart:
                              Colors.black45.withOpacity(0.4),
                          borderColorEnd: Color(0xFFBF2041),
                          animatedWidgetFollowingHeader: Icon(
                            Icons.expand_more,
                          ),
                          headerExpanded: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Rifle',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          header: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Rifle',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          children: <Widget>[
                            CardsList(
                                weaponNamesByType: weaponNames['rifle'],
                                type: 'rifle'),
                          ]),
                      ConfigurableExpansionTile(
                          headerBackgroundColorStart:
                              Colors.black45.withOpacity(0.4),
                          borderColorEnd: Color(0xFFBF2041),
                          animatedWidgetFollowingHeader: Icon(
                            Icons.expand_more,
                          ),
                          headerExpanded: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Sniper',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          header: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Sniper',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          children: <Widget>[
                            CardsList(
                                weaponNamesByType: weaponNames['sniper'],
                                type: 'sniper'),
                          ]),
                      ConfigurableExpansionTile(
                          headerBackgroundColorStart:
                              Colors.black45.withOpacity(0.4),
                          borderColorEnd: Color(0xFFBF2041),
                          animatedWidgetFollowingHeader: Icon(
                            Icons.expand_more,
                          ),
                          headerExpanded: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Heavy',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          header: Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text('Heavy',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontFamily: "Valorant")),
                          ),
                          children: <Widget>[
                            CardsList(
                                weaponNamesByType: weaponNames['heavy'],
                                type: 'heavy'),
                          ]),
                    ],
                  ),
                ),
                bottomNavigationBar: Footer(),
              ))),
    );
  }
}

class CardsList extends StatelessWidget {
  final dynamic weaponNamesByType;
  final String type;

  const CardsList({Key key, this.weaponNamesByType, this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: weaponNamesByType?.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Container(
            height: 100,
            child: Card(
              color: Color(0xF0F111A).withOpacity(0.7),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    weaponNamesByType[index]['name'],
                    style: TextStyle(
                        color: Color(0xFF00FFA4),
                        fontSize: 18,
                        fontFamily: "Valorant"),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    "assets/images/weapons/${weaponNamesByType[index]['name']}.png",
                    width: 200,
                  ),
                ),
                onTap: () {
                  RoutArgument routArgument = RoutArgument();
                  routArgument.weaponArguments = WeaponArguments(type, index);
                  Navigator.pushNamed(context, '/weaponDetails',
                      arguments: routArgument);
                },
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 0,
      ),
    );
  }
}
