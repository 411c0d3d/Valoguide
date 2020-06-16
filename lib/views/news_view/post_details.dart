import 'dart:math';
import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/views/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  String coverGen() {
    return "cover" + Random().nextInt(5).toString() + ".jpg";
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
                        widget.args.post.title,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 22, color: Color(0xFF00FFA4)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 250,
                        child: (widget.args.post.cover != '')
                            ? FadeInImage.assetNetwork(
                                placeholder:
                                    "assets/images/background/loading.png",
                                image: widget.args.post.cover,
                                fit: BoxFit.cover)
                            : (widget.args.post.figure != '')
                                ? Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/images/background/loading.png",
                                        image: widget.args.post.figure,
                                        fit: BoxFit.cover))
                                : Image.asset(
                                    "assets/images/newsCovers/cover${Random().nextInt(5).toString()}.jpg"),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 5),
                            child: (widget.args.post != null)
                                ? (widget.args.post.author != '')
                                    ? Text(
                                        " by : " + widget.args.post.author,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        "Author : Loading",
                                        style: TextStyle(color: Colors.white),
                                      )
                                : null),
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 5),
                            child: (widget.args.post != null)
                                ? (widget.args.post.date != '')
                                    ? Text(
                                        " - " + widget.args.post.date,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        "Date : Loading",
                                        style: TextStyle(color: Colors.white),
                                      )
                                : null),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.args.post.content,
                        style: TextStyle(fontSize: 18, fontFamily: "Tisa Sans"),
                      ),
                    ),
                    if (widget.args.post.figure != '' &&
                        widget.args.post.cover != '')
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/background/loading.png",
                              image: widget.args.post.figure,
                              fit: BoxFit.cover))
                  ],
                )),
          ),
          bottomNavigationBar: Footer(),
        ),
      ),
    );
  }
}
