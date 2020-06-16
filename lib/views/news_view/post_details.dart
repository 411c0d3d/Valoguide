import 'dart:math';
import 'package:Valoguide/core/constants/adMob.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatefulWidget {
  final args;

  const PostDetails({Key key, this.args}) : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WillPopCallback onWillPopFirst = () {
      if (new Random().nextInt(2) == new Random().nextInt(2))
        Ads?.showInterstitialAd();
      return Future.value(true);
    };

    return WillPopScope(
      onWillPop: onWillPopFirst,
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
              "News & Updates",
              style: TextStyle(fontFamily: "Orbitron"),
            )),
          ),
          backgroundColor: Color(0xF0B102F).withOpacity(0.5),
          body: SingleChildScrollView(
            child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.args.postTitle,
                        style:
                            TextStyle(fontSize: 22, color: Color(0xFF00FFA4)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.args.postContent,
                        style: TextStyle(fontSize: 18, fontFamily: "Tisa Sans"),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
