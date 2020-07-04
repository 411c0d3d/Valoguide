import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/views/footer.dart';
import 'package:flutter/material.dart';

class ComingSoon extends StatefulWidget {
  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  void initState() {
    // TODO: implement initState
    Ads?.showBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Valorant Master Guide',
                style: TextStyle(fontFamily: "Orbitron"),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: 200,
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                    image: AssetImage("assets/images/background/texture02.png"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage("assets/images/background/loader02.jpg"),
                  ),
                  Text(
                    "Coming soon ...",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Footer(),
        ),
      ),
    );
  }
}
